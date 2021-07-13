//
//  Action+Extensions.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/6/4.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import Action
import RxSwift

public typealias InputOutputSameAction<Element> = Action<Element, Element>

public extension Action where Input == Element {
    
    static func create() -> Action {
        Action { Observable.just($0) }
    }
}
