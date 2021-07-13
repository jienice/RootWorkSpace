// 
//  RefreshStatusSendable.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import BasicFramework

fileprivate var refreshStatusKey: UInt8 = 0
public protocol RefreshStatusSendable: Object {

    var refreshStatus: BehaviorRelay<RefreshStatus?> { get }

    func send(_ refresh: RefreshStatus)
}

public extension RefreshStatusSendable {

    var refreshStatus: BehaviorRelay<RefreshStatus?> {
        getAssociatedObjectIfNilSet(self, &refreshStatusKey) {
            BehaviorRelay<RefreshStatus?>(value: nil)
        }
    }

    func send(_ refresh: RefreshStatus) {
        refreshStatus.accept(refresh)
    }

}
