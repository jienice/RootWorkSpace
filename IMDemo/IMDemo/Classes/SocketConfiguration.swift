//
//  SocketConfiguration.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/3.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

public protocol SocketConfiguration: Configuration {
    
    var host: String {get}
    var port: UInt16 {get}
    var reconnectCount: Int {get}
    var beatTimeInterval: TimeInterval {get}
    var readWriteTimeOut: TimeInterval {get}
}
