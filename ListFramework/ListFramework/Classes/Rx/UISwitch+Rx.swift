//
//  UISwitch+Rx.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UISwitch {

    var onTintColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.onTintColor = attr
        }
    }

    var thumbTintColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.thumbTintColor = attr
        }
    }
}
