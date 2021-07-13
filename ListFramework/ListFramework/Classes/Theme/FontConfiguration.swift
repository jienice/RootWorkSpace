// 
//  FontConfiguration.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/6/1.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import BasicFramework

public protocol FontConfiguration: Configuration {

    var title: UIFont {get}
    var detail: UIFont {get}
    var placeholder: UIFont {get}
}
