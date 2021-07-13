//
//  SocketStatusHandleChain.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/4.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

protocol SocketStatusHandleChain: Order {

    func handle(status: SocketStatus)
}
