// 
//  Recorder.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/7/12.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework
import AVFoundation
import RxCocoa
import RxSwift

public protocol RecorderConfiguration: Configuration  {

    var maxTimeInterval: TimeInterval {get}

    var countDownTimeInterval: TimeInterval {get}
    /// Key: AVFoundation.AVFAudio.AVAudioSettings
    var recordSettings: [String: AnyObject] {get}

    var filePath: String {get}
}

public class Recorder: NSObject {

    public enum State {
        case none
        case recording
    }

    let session = AVAudioSession.sharedInstance()

    var recorder: AVAudioRecorder?

    let state = BehaviorRelay<Recorder.State?>(value: nil)

    var recordTimerDisposeBag = DisposeBag()

    let duration = BehaviorRelay<TimeInterval?>(value: nil)

    let countDownTime = BehaviorRelay<TimeInterval?>(value: nil)

    let configuration: RecorderConfiguration

    init(configuration: RecorderConfiguration) {
        self.configuration = configuration
        super.init()
        FileManager.default.directoryIsExistsIfNotCreate(at: configuration.filePath)
        state.filterNil()
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] in
                    switch $0 {
                    case .none:
                        self?.stopRecordTimer()
                    case .recording:
                        self?.fireRecordTimer()
                    }
                }).disposed(by: rx.disposeBag)

        duration
                .filterNil()
                .filter { $0 >= configuration.maxTimeInterval - configuration.countDownTimeInterval && $0 <= configuration.maxTimeInterval }
                .map { configuration.maxTimeInterval - $0 }
                .bind(to: countDownTime)
                .disposed(by: rx.disposeBag)
    }

}

// MARK: - TmpRecordPath
extension Recorder: Identifiable {

    func tmpRecordPath() -> URL {
        URL(fileURLWithPath: configuration.filePath).appendingPathComponent(Recorder.identifier() + ".caf")
    }

}

// MARK: - Record Time
extension Recorder {

    func fireRecordTimer() {
        stopRecordTimer()
        duration.accept(nil)
        Observable<Int>
                .interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .map { TimeInterval(1 + $0) }
                .bind(to: duration)
                .disposed(by: recordTimerDisposeBag)
    }

    func stopRecordTimer() {
        recordTimerDisposeBag = DisposeBag()
        countDownTime.accept(nil)
    }
}

// MARK: - Record
extension Recorder {

    private func prepare() {
        recorder = try? AVAudioRecorder(url: tmpRecordPath(), settings: configuration.recordSettings)
        try? session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default)
        try? session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        try? session.setActive(true)
        recorder?.prepareToRecord()
    }

    func record() {
        guard state.value != .recording else { return }
        prepare()
        guard recorder != nil else { return }
        recorder?.record()
        state.accept(.recording)
    }

    func stopRecord(_ complete: (()-> Void)? = nil) {
        guard state.value == .recording else { return }
        recorder?.stop()
        state.accept(Recorder.State.none)
        complete?()
    }

    private func playOtherMusic() throws {
        try session.setActive(false, options: .notifyOthersOnDeactivation)
    }
}

/*
extension Recorder {

    static func encodeRecordWAVEToAMR(url: URL) -> Data? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return EncodeWAVEToAMR(data, 1, 16)
    }
}
*/