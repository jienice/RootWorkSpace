//
//  DefaultThemeConfiguration.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/9.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit
import ListFramework

struct DefaultColorConfiguration: ColorConfiguration {

    private(set) var title: UIColor = UIColor.black

    private(set) var detail: UIColor = UIColor.systemGray2

    private(set) var placeholder: UIColor = UIColor.systemGray3

    private(set) var border: UIColor = UIColor.systemRed

    private(set) var background: UIColor = UIColor.white

    private(set) var highlighted: UIColor = UIColor.systemRed

    private(set) var primary: UIColor = UIColor.systemRed
}

struct DefaultFontConfiguration: FontConfiguration {

    private(set) var title: UIFont = UIFont.boldSystemFont(ofSize: 15)

    private(set) var detail: UIFont = UIFont.systemFont(ofSize: 13)

    private(set) var placeholder: UIFont = UIFont.systemFont(ofSize: 15)
    
}

struct DefaultThemeConfiguration: ThemeConfiguration {

    private(set) static var color: ColorConfiguration = DefaultColorConfiguration()

    private(set) static var font: FontConfiguration = DefaultFontConfiguration()
}
