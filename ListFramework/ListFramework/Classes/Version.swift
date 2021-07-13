// 
//  Version.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/7/12.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import BasicFramework
import Action

public struct Version {

    let containNewerVersion = BehaviorRelay<Bool>(value: false)

    let isForceUpdateVersion = BehaviorRelay<Bool>(value: false)

    let checkVersionRes = BehaviorRelay<(Bool, Bool)>(value: (false, false))

    let checkVersion: Action<Void, (Bool, Bool)>

    init(action: Action<Void, (Bool, Bool)>, disposeBag: DisposeBag) {
        self.checkVersion = action
        checkVersion.executionObservables
                .switchLatest()
                .map { $0.0 }
                .bind(to: containNewerVersion)
                .disposed(by: disposeBag)

        checkVersion.executionObservables
                .switchLatest()
                .map { $0.1 }
                .bind(to: isForceUpdateVersion)
                .disposed(by: disposeBag)

        checkVersion.executionObservables
                .switchLatest()
                .skip(1)
                // 最新检查结果为强制更新则必须弹出，否则2次结果不同再弹出
                .distinctUntilChanged { $1.1 ? false : ($0.0 == $1.0) && ($0.1 == $1.1) }
                .bind(to: checkVersionRes)
                .disposed(by: disposeBag)
    }
}
