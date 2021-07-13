// 
//  ColorConfiguration.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/6/1.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import BasicFramework

public protocol ColorConfiguration: Configuration {

    var title: UIColor {get}
    var detail: UIColor {get}
    var placeholder: UIColor {get}
    var border: UIColor {get}
    var background: UIColor {get}
    var highlighted: UIColor {get}
    var primary: UIColor {get}
}
