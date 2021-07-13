//
//  Runtime.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/10/14.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation

public func getAssociatedObjectIfNilSet<T>(_ object: Any, _ key: UnsafeRawPointer, defaultValue: () -> T) -> T {
    if let lookup = objc_getAssociatedObject(object, key) as? T {
        return lookup
    } else {
        let value = defaultValue()
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return value
    }
}

public func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
