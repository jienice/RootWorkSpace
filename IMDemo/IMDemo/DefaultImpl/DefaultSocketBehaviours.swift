//
//  DefaultSocketBehaviours.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/10.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CocoaAsyncSocket

struct DefaultSocketConfiguration: SocketConfiguration {

    private(set) var host: String = ""

    private(set) var port: UInt16 = 1

    private(set) var reconnectCount: Int = 10

    private(set) var beatTimeInterval: TimeInterval = 30

    private(set) var readWriteTimeOut: TimeInterval = 30
}

class DefaultSocketBehaviours: SocketBehaviours {

    private(set) var status = BehaviorRelay<SocketStatus>(value: .disconnected)

    private(set) var encoder: SocketDataEncoder = DefaultSocketDataEncoder()

    private(set) var decoder: SocketDataDecoder = DefaultSocketDataDecoder()

    private(set) var configuration: SocketConfiguration = DefaultSocketConfiguration()

    private(set) var imMessageReceivedCompoundHandler: ImMessageReceivedCompoundHandler = ImMessageReceivedCompoundHandler()
    
    func connect() {
        
    }
    
    func reconnect() {
        
    }
    
    func disconnect() {
        
    }
    
    func sendData(_ data: SocketSendElement) {
        
    }
    
    func readData() {
        
    }
}
