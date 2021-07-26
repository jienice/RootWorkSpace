//
//  Value.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/7/16.
//

import Foundation
import SwifterSwift
import SwiftyJSON

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
            return JSON(fileContent)[key] as? Result
        }
    }
    
    public init(resource: String = "info", key: String) {
        self.key = key
        self.resource = resource
    }
}


