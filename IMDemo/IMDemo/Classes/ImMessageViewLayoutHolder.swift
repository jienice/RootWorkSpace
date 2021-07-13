// 
//  ImMessageViewLayoutHolder.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/25.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import CollectionKit
import Action

/// Hold ViewLayout
protocol ImMessageViewLayoutHolder {

    var dataSource: ArrayDataSource<ViewLayout> {get}

    var layoutChanged: CocoaAction {get}

    func padding(_ layout: ViewLayout)

    func update(_ layout: ViewLayout)

    func initializeDataSource(_ dataSource: [ViewLayout])
}
