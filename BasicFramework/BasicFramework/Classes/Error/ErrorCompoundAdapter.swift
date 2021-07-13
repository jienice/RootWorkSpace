//
//  ErrorCompoundAdapter.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/6/1.
//

import Foundation

public protocol ErrorAdaptable {
        
    func trans() -> DefaultError?
}


public struct ErrorCompoundAdapter: Compound {
    
    public typealias Substance = ErrorAdaptable
    
    public var substances = [ErrorAdaptable]()

    public func adapt(error: Error) -> DefaultError? {
        for adapter in substances {
            if let defaultError = adapter.trans() {
                return defaultError
            }
        }
        return nil
    }
}
