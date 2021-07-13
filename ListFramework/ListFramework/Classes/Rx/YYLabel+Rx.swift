//
//  YYLabel+Rx.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import YYText

public extension Reactive where Base: YYLabel {
    
    var textColor: Binder<UIColor> {
        return Binder(self.base) { label, color in
            label.textColor = color
        }
    }
    
    var borderColor: Binder<UIColor> {
        return Binder(self.base) { label, color in
            label.borderColor = color
        }
    }
}
