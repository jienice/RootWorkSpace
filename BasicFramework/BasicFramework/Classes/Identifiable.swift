//
//  Identifieable.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/5/13.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation

public protocol Identifiable {
    
    static func identifier(_ prettify: Bool) -> String
}

public extension Identifiable {
    
    static func identifier(_ prettify: Bool = true) -> String {
        var uuid = UUID().uuidString
        if prettify {
            uuid.removeAll(where: { $0 == "-" })
        }
        return uuid
    }
}

