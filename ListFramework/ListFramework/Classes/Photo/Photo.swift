//
//  Photo.swift
//  ListFramework
//
//  Created by jie.xing on 2021/5/30.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Photos
import AVFoundation
import UIKit
import TZImagePickerController
import BasicFramework
import SwifterSwift

public protocol PhotoDelegate: Object {
    
    func photoDidCancel()
    
    func photoDidFinishSelected(result: Photo.Result)
    
    func photoExportingAsset(assets: [PHAsset])
    
    func photoDidFinishExportAsset(assets: [PHAsset])

    func photoDidGetError(error: DefaultError)
    
    func photoDidFinishSaveImage(image: UIImage)
}

public final class Photo: Object {
    
    public struct Result {
        public let photos: [String]
        public let videos: [String]
    }
    
    weak var delegate: PhotoDelegate?

    let configuration: PhotoConfiguration

    init(configuration: PhotoConfiguration, delegate: PhotoDelegate? = nil) {
        self.configuration = configuration
        self.delegate = delegate
        super.init()
    }

}

// MARK: - Export Video/Images to SandBox
private extension Photo {
    
    func exportVideoWithVideoAsset(videoAsset: AVURLAsset, presetName: String, complete: ((String?) -> Void)? = nil) {
        guard AVAssetExportSession.exportPresets(compatibleWith: videoAsset).contains(presetName) else {
            delegate?.photoDidGetError(error: Errors.System.custom(msg: "当前设备不支持该预设: \(presetName)"))
            complete?(nil)
            return
        }
        guard let session = AVAssetExportSession.init(asset: videoAsset, presetName: presetName) else {
            delegate?.photoDidGetError(error: Errors.System.custom(msg: "导出失败"))
            complete?(nil)
            return
        }
        guard !session.supportedFileTypes.isEmpty else {
            delegate?.photoDidGetError(error: Errors.System.custom(msg: "该视频类型暂不支持导出"))
            complete?(nil)
            return
        }
        let videoFilePath = configuration.videoFilePath
        session.outputFileType = session.supportedFileTypes.first
        session.outputURL = URL.init(fileURLWithPath: videoFilePath)
        session.shouldOptimizeForNetworkUse = true
        session.exportAsynchronously { [weak self] in
            DispatchQueue.main.async {
                switch session.status {
                case .cancelled:
                    self?.delegate?.photoDidCancel()
                case .failed:
                    self?.delegate?.photoDidGetError(error: Errors.System.custom(msg: "视频导出失败"))
                    complete?(nil)
                case .completed:
                    complete?(videoFilePath)
                case .exporting:
                    break
                case .unknown:
                    break
                case .waiting:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func getVideoOutPutWithAsset(asset: PHAsset, presetName: String = AVAssetExportPreset640x480, complet: @escaping (String?) -> Void) {
        let options = PHVideoRequestOptions.init()
        options.version = .original
        options.deliveryMode = .automatic
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestAVAsset(forVideo: asset, options: options) { [weak self] (videoAsset, _, _) in
            guard let asset = videoAsset as? AVURLAsset else {
                return
            }
            self?.exportVideoWithVideoAsset(videoAsset: asset, presetName: presetName, complete: {
                complet($0)
            })
        }
    }
    
    func getImageOutput(from asset: PHAsset, complete: @escaping (String?) -> Void) {
        TZImageManager.default().getOriginalPhotoData(with: asset) { [weak self] (data, _, _) in
            if let path = self?.configuration.imageFilePath,
               let data = data,
               let compressionQuality = self?.configuration.compressionQuality,
               let imgData = UIImage.init(data: data)?.fixOrientation().compressedData(quality: compressionQuality) {
                complete(FileManager.default.createFile(atPath: path, contents: imgData, attributes: nil) ? path: nil)
            } else {
                complete(nil)
            }
        }
    }
    
    func getImagesOutput(from assets: [PHAsset], complete: @escaping ([String]) -> Void) {
        FileManager.default.directoryIsExistsIfNotCreate(at: configuration.imageDirectory)
        let group = DispatchGroup()
        var photoPaths = [String?]()
        assets.forEach { [weak self] in
            group.enter()
            self?.getImageOutput(from: $0, complete: {
                photoPaths.append($0)
                group.leave()
            })
        }
        group.notify(queue: DispatchQueue.main) {
            complete(photoPaths.compactMap {$0})
        }
    }
    
}

// MARK: - TZImagePickerControllerDelegate
extension Photo: TZImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        guard let input = assets as? [PHAsset] else {
            return
        }
        let photoAssets = input.filter { $0.mediaType == .image }.compactMap {$0}
        delegate?.photoExportingAsset(assets: photoAssets)
        getImagesOutput(from: photoAssets) { [weak self] in
            self?.delegate?.photoDidFinishExportAsset(assets: photoAssets)
            self?.delegate?.photoDidFinishSelected(result: Result(photos: $0, videos: [String]()))
        }
    }
    
    public func tz_imagePickerControllerDidCancel(_ picker: TZImagePickerController!) {
        delegate?.photoDidCancel()
    }
}

extension Photo: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.delegate = nil
        picker.dismiss(animated: true, completion: { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            guard let configuration = self?.configuration else { return }
            guard let data = image.fixOrientation().jpegData(compressionQuality: configuration.compressionQuality) else { return }
            let filePath = configuration.imageFilePath
            FileManager.default.directoryIsExistsIfNotCreate(at: configuration.imageDirectory)
            FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
            self?.delegate?.photoDidFinishSelected(result: Result.init(photos: [filePath], videos: [String]()))
        })
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        delegate?.photoDidCancel()
    }
    
    public func takePhoto() {
        switch DeviceAuthorize.authorizationStatus(forMediaType: .video) {
        case .notAuthorized:
            sendCameraAuthorizeError()
        case .notDetermined:
            DeviceAuthorize.requestAuthorization(forMediaType: .video, completionHandler: { [weak self] in
                switch $1 {
                case .authorized:
                    self?.createTakePhotoPickerAndShow()
                case .notAuthorized:
                    self?.sendCameraAuthorizeError()
                case .notDetermined:
                    break
                }
            })
        case .authorized:
            createTakePhotoPickerAndShow()
        }
    }
    
    @discardableResult
    private func createTakePhotoPickerAndShow() -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.delegate = self
        UIApplication.topController().present(imagePicker, animated: true, completion: nil)
        return imagePicker
    }
    
    private func sendCameraAuthorizeError() {
        delegate?.photoDidGetError(error: Errors.Authorize.camera)
    }
    
}


extension Photo {
    
    public func selectPhoto(maxCount: Int = 1) {
        DeviceAuthorize.authorizeStatusPhotoAlbum { [weak self] in
            if $0 == .authorized {
                let picker = TZImagePickerController.defaultPhotoSelectPicker(maxCount: maxCount, delegate: self)
                UIApplication.topController().present(picker, animated: true, completion: nil)
            } else {
                self?.sendPhotoAlbumAuthorizeError()
            }
        }
    }
    
    public func saveImage(image: UIImage) {
        DeviceAuthorize.authorizeStatusPhotoAlbum { [weak self] in
            if $0 == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetCreationRequest.creationRequestForAsset(from: image)
                }, completionHandler: {
                    if let error = $1 {
                        self?.delegate?.photoDidGetError(error: Errors.System.custom(msg: error.localizedDescription))
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.delegate?.photoDidFinishSaveImage(image: image)
                        }
                    }
                })
            } else {
                self?.sendPhotoAlbumAuthorizeError()
            }
        }
    }
    
    private func sendPhotoAlbumAuthorizeError() {
        delegate?.photoDidGetError(error: Errors.Authorize.photoAlbum)
    }
}


extension TZImagePickerController {
    
    static func defaultPhotoSelectPicker(maxCount: Int, delegate: TZImagePickerControllerDelegate?) -> TZImagePickerController {
        let picker = TZImagePickerController(maxImagesCount: maxCount, delegate: delegate)!
        picker.allowPickingOriginalPhoto = false
        picker.allowPickingImage = true
        picker.allowTakePicture = false
        picker.allowTakeVideo = false
        picker.allowPickingVideo = false
        picker.allowPickingMultipleVideo = false
        picker.defaultSet()
        return picker
    }
    
    func defaultSet() {
        allowPreview = true
        allowPickingGif = false
        navigationBar.isTranslucent = false
//        naviBgColor = UIColor.barTintColor()
//        barItemTextColor = UIColor.text()
//        navigationBar.tintColor = UIColor.text()
//        naviTitleColor = UIColor.text()
//        oKButtonTitleColorNormal = UIColor.primary()
//        oKButtonTitleColorDisabled = UIColor.primary().withAlphaComponent(0.5)
//        iconThemeColor = UIColor.primary()
//        statusBarStyle = themeService.type.associatedObject.statusBarStyle
        modalPresentationStyle = .fullScreen
    }
}
