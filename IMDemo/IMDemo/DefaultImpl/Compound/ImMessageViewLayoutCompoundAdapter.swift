// 
//  ImMessageViewLayoutCompoundAdapter.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

/// Compound Adapter
struct ImMessageViewLayoutCompoundAdapter: Compound {

    typealias Substance = ImMessageViewLayoutAdapterChain

    private(set) var substances = [ImMessageViewLayoutAdapterChain]()

    func adapt(_ element: ImMessage) -> ViewLayout? {
        if let text = element as? DefaultTextMessage {
            return DefaultTextMessageViewLayout.init(innerMessage: text)
        }
        return nil
    }

    func batchAdapt(_ elements: [ImMessage]) -> [ViewLayout] {
        elements
            .map { adapt($0) }
            .compactMap {$0}
    }

}
