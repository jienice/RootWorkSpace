// 
//  JSONMappable.swift
//  BasicFramework
// 
//  Created by jie.xing on 2021/5/30.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import SwiftyJSON

public protocol JSONMappable {

    static func create(from json: JSON) -> Self
    
    var data: JSON{get}
}

public protocol JSONOptionalMappable {

    static func create(from json: JSON) -> Self?
    
    var data: JSON?{get}
}

public protocol List: JSONMappable {
    
    var dataSource: [JSON] {get set}
}

public protocol Response: JSONMappable {

}
