// 
//  SocketData.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/3.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

/// Socket Send Element
public protocol SocketSendElement {

    var data: Data {get}
}

/// Decode To ImMessage
public protocol SocketDataDecoder {

    func decode(data: SocketSendElement) -> ImMessage?
}

/// Encode To SocketSendElement
public protocol SocketDataEncoder {

    func encode(message: ImMessage) -> SocketSendElement?
}
