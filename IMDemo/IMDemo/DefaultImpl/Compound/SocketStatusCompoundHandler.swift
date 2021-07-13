// 
//  SocketStatusCompoundHandler.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

struct SocketStatusCompoundHandler: Compound {

    public typealias Substance = SocketStatusHandleChain

    private(set) var substances = [SocketStatusHandleChain]()

    func doHandle(_ status: SocketStatus) {
        for substances in substances.sorted(by: { $0.order < $1.order }) {
            substances.handle(status: status)
        }
    }
}

