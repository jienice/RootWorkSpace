// 
//  DefaultImMessageViewLayoutHolder.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import Action
import CollectionKit

struct DefaultImMessageViewLayoutHolder: ImMessageViewLayoutHolder {

    private(set) var dataSource: ArrayDataSource<ViewLayout> = ArrayDataSource<ViewLayout>.init(data: [])

    private(set) var layoutChanged: CocoaAction = .create()

    func initializeDataSource(_ dataSource: [ViewLayout])  {
        self.dataSource.data = dataSource
    }

    func padding(_ layout: ViewLayout) {
        dataSource.data.append(layout)
    }

    func update(_ layout: ViewLayout) {

    }
}
