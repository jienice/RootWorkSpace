//
//  UIScrollView+Rx.swift
//  ListFramework
//
//  Created by jie.xing on 2021/6/8.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import MJRefresh

fileprivate var headerRefreshKey: UInt8 = 0
fileprivate var footerRefreshKey: UInt8 = 0

public extension Reactive where Base: UIScrollView {
    
    var headerRefresh: CocoaAction {
        if let action = objc_getAssociatedObject(base, &headerRefreshKey) as? CocoaAction {
            return action
        } else {
            let action = CocoaAction.create()
            self.base.mj_header = HeaderRefresh.create {
                action.execute()
            }
            objc_setAssociatedObject(base, &headerRefreshKey, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return action
        }
    }
    
    var footerRefresh: CocoaAction {
        if let action = objc_getAssociatedObject(base, &footerRefreshKey) as? CocoaAction {
            return action
        } else {
            let action = CocoaAction.create()
            self.base.mj_footer = FooterRefresh.create {
                action.execute()
            }
            objc_setAssociatedObject(base, &footerRefreshKey, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return action
        }
    }
}
