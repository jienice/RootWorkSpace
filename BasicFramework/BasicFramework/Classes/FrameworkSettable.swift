//
//  FrameworkSettable.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/7/7.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation

public protocol FrameworkSettable {
    
    static var name: String {get}
    static var resource: String {get}
    static var bundle: Bundle? {get}
}
