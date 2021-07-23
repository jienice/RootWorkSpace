//
//  Value.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/7/16.
//

import Foundation
import SwifterSwift

@propertyWrapper
public struct PlistValue<Result> {
    
    public let key: String
    
    public let resource: String
    
    public var wrappedValue: Result? {
        get {
            guard let URL = Bundle.main.url(forResource: resource, withExtension: "plist") else {
                return nil
            }
            guard let fileContent = NSDictionary(contentsOf: URL) as? [String: Any] else {
                return nil
            }
            return fileContent[key] as? Result
        }
    }
}


