//
//  DeviceAuthorize.swift
//  ListFramework
//
//  Created by jie.xing on 2020/5/13.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import Photos
import RxSwift
import RxCocoa

struct DeviceAuthorize {
    
    enum Status {
        case notDetermined
        case notAuthorized
        case authorized
    }
        
    /// 验证(请求)相册权限
    static func authorizeStatusPhotoAlbum(complete: @escaping (Status) -> Void) {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case .authorized:
            complete(.authorized)
        case .denied, .restricted:
            complete(.notAuthorized)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    complete(status == .authorized ? .authorized: .notAuthorized)
                }
            })
        case .limited:
            complete(.authorized)
        @unknown default:
            debugPrint("unknown authorization type")
        }
    }
    
    /// 请求权限
    static func requestAuthorization(forMediaType mediaType: AVMediaType, completionHandler: @escaping (AVMediaType, Status) -> Void) {
        AVCaptureDevice.requestAccess(for: mediaType) { (granted: Bool) in
            DispatchQueue.main.async {
                completionHandler(mediaType, (granted ? .authorized : .notAuthorized))
            }
        }
    }
    
    /// 获取权限状态
    static func authorizationStatus(forMediaType mediaType: AVMediaType) -> Status {
        let settedStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        var status: Status = .notDetermined
        switch settedStatus {
        case .denied, .restricted:
            status = .notAuthorized
        case .authorized:
            status = .authorized
        case .notDetermined:
            break
        @unknown default:
            debugPrint("unknown authorization type")
        }
        return status
    }
    
}

extension Reactive where Base == DeviceAuthorize {
    
    static func authorizeStatusPhotoAlbum() -> Observable<Base.Status> {
        return Observable.create { (observer) -> Disposable in
            DeviceAuthorize.authorizeStatusPhotoAlbum {
                observer.onNext($0)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    static func authorizationStatus(forMediaType mediaType: AVMediaType) -> Observable<Base.Status> {
        return Observable.create { (observer) -> Disposable in
            observer.onNext(DeviceAuthorize.authorizationStatus(forMediaType: mediaType))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    static func requestAuthorization(forMediaType mediaType: AVMediaType) -> Observable<(AVMediaType, Base.Status)> {
        return Observable.create { (observer) -> Disposable in
            DeviceAuthorize.requestAuthorization(forMediaType: mediaType) {
                observer.onNext(($0, $1))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
