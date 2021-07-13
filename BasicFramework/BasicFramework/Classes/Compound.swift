//
//  Compound.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/6/4.
//

import Foundation

public protocol Compound {
    
    associatedtype Substance
    
    var substances: [Substance] {get}
}
