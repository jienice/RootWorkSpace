// 
//  ImMessageHandleChain.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/4.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework
import RxCocoa

public protocol ImMessageReceivedHandleChain: Order {

    func handle(message: ImMessage)
}
