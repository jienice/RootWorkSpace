//
//  UITableView+Rx.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UITableView {
    
    var separatorColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.separatorColor = attr
        }
    }
    
}
