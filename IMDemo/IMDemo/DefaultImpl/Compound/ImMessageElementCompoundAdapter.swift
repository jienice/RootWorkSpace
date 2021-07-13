// 
//  ImMessageElementCompoundAdapter.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

/// Compound Adapter
struct ImMessageElementCompoundAdapter: Compound {

    typealias Substance = ImMessageElementAdapterChain

    private(set) var substances = [ImMessageElementAdapterChain]()

    func adapt(_ element: ImMessageElement) -> ImMessage? {
        return nil
    }
}
