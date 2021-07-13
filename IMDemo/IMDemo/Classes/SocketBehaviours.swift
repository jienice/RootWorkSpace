// 
//  Socket.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/3.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework
import RxCocoa

public enum SocketStatus {

    case connected
    case connecting
    case connectFail
    case reconnecting
    case reconnectFail
    case disconnected
}

public protocol SocketBehaviours {

    /// Notify Socket Connect Status
    var status: BehaviorRelay<SocketStatus> {get}

    /// Encode ImMessage To SocketSendElement
    var encoder: SocketDataEncoder {get}

    /// Decode SocketSendElement To ImMessage
    var decoder: SocketDataDecoder {get}

    /// Socket Server Config
    var configuration: SocketConfiguration {get}

    /// Handle ImMessage
    var imMessageReceivedCompoundHandler: ImMessageReceivedCompoundHandler {get}

    func connect()
    
    func reconnect()

    func disconnect()

    func sendData(_ data: SocketSendElement)
    
    func readData()
}

public extension SocketBehaviours {

    /// Default Send ImMessage Impl
    func sendImMessage(_ message: ImMessage) {
        guard let sendElement = encoder.encode(message: message) else {
            return
        }
        sendData(sendElement)
    }
}
