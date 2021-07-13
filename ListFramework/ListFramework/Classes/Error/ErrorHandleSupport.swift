// 
//  ErrorHandleSupport.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/30.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

public extension ErrorHandleable where Self: ScrollViewTagSetTargetCatchier {

    func handleNoNetWork(_ error: DefaultError) {
        target?.emptyDataStatus = .noNetWork
        target?.updateEmptyDataSet()
    }

    func handleRequestError(_ error: DefaultError) {
        target?.emptyDataStatus = .networkError
        target?.updateEmptyDataSet()
    }
}
