// 
//  ImMessageViewLayout.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/25.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import BasicFramework

public enum ImMessageAlignment {
    case other
    case me
}

protocol ViewLayout {

    var frame: CGRect {get}
}

/// Message Layout
protocol ImMessageViewLayout: ViewLayout {
    
    associatedtype Message: ImMessage
    
    associatedtype Configuration: ImMessageViewLayoutConfiguration

    var innerMessage: Message {get}

    var configuration: Configuration {get}
    
    var alignment: ImMessageAlignment {get}
}
