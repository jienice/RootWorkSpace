//
//  ThemeConfiguration.swift
//  Basic
//
//  Created by jie.xing on 2021/05/28.
//  Copyright © 2021 jie.xing All rights reserved.
//
import UIKit
import BasicFramework

public protocol ThemeConfiguration: Configuration {

    static var color: ColorConfiguration {get}
    static var font: FontConfiguration {get}
}
