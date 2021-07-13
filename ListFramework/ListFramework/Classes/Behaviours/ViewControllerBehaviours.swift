// 
//  ViewControllerBehaviours.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

public protocol ViewControllerBehaviours: ViewController {

    func configUI()

    func bindViewModel()
}
