//
//  YYTextView+Rx.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import YYText

public extension Reactive where Base: YYTextView {
    
    var textColor: Binder<UIColor> {
        return Binder(self.base) { textView, color in
            textView.textColor = color
        }
    }
    
    var borderColor: Binder<UIColor> {
        return Binder(self.base) { textView, color in
            textView.borderColor = color
        }
    }
}
