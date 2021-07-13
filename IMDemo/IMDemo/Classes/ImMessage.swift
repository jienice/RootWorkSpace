// 
//  ImMessage.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/4.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

/// Type alias Message Can Send, like text, url etc
public protocol ImMessageElement {}

extension String: ImMessageElement {}

/// Type alias Message
public protocol ImMessage {}

public protocol ResourceImMessage: ImMessage {
    
    var localUrl: String{get}
    var remoteUrl: String? {get}
}

public protocol TextMessage: ImMessage {
    
    var text: String {get}
}

public protocol VideoMessage: ResourceImMessage {}

public protocol VoiceMessage: ResourceImMessage {}

public protocol ImageMessage: ResourceImMessage {}

/// Trans Element To ImMessage
public protocol ImMessageElementAdapterChain {

    func trans(_ input: ImMessageElement) -> ImMessage
}
