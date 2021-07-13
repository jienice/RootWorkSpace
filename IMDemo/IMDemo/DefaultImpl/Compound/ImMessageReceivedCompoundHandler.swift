// 
//  ImMessageReceivedCompoundHandler.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework
import RxCocoa

/// This Class Only Handle Received Message. After This Action, Pass ImMessage To Adapter
public struct ImMessageReceivedCompoundHandler: Compound {

    public typealias Substance = ImMessageReceivedHandleChain

    public var substances = [ImMessageReceivedHandleChain]()

    var handledMessage = BehaviorRelay<ImMessage?>(value: nil)

    func doHandle(_ message: ImMessage) {
        for substances in substances.sorted(by: { $0.order < $1.order }) {
            substances.handle(message: message)
        }
        handledMessage.accept(message)
    }
}
