// 
//  PageSettable.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import BasicFramework

fileprivate var pageKey: UInt8 = 0
fileprivate var totalPageKey: UInt8 = 0

public protocol PageSettable: Object {

    var page: BehaviorRelay<Int> {get}
    var totalPage: BehaviorRelay<Int> {get}
}

public extension PageSettable {

    var page: BehaviorRelay<Int> {
        getAssociatedObjectIfNilSet(self, &pageKey) {
            BehaviorRelay<Int>(value: 0)
        }
    }

    var totalPage: BehaviorRelay<Int> {
        getAssociatedObjectIfNilSet(self, &totalPageKey) {
            BehaviorRelay<Int>(value: 0)
        }
    }

    @discardableResult
    func resetPage() -> Int {
        page.accept(1)
        totalPage.accept(0)
        return page.value
    }

    @discardableResult
    func increasePage() -> Int {
        page.accept(page.value + 1)
        return page.value
    }

    @discardableResult
    func decreasePage() -> Int {
        page.accept(page.value > 0 ? page.value - 1 : 0)
        return page.value
    }

    func cacheTotalPages(value: Int) {
        totalPage.accept(value)
    }
}