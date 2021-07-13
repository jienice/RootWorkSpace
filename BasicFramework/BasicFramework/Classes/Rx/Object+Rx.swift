//
//  Object+Rx.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/5/29.
//

import RxSwift

public typealias Object = NSObject

fileprivate var disposeBagKey: UInt8 = 0
fileprivate var reuseDisposeBagKey: UInt8 = 0

extension Reactive where Base: Object {
    
    func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}

public extension Reactive where Base: Object {

    var disposeBag: DisposeBag {
        get {
            synchronizedBag {
                getAssociatedObjectIfNilSet(base, &disposeBagKey, defaultValue: {
                    DisposeBag()
                })
            }
        }
        
        set {
            synchronizedBag {
                objc_setAssociatedObject(base, &disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    var reuseDisposeBag: DisposeBag {
        get {
            synchronizedBag {
                getAssociatedObjectIfNilSet(base, &reuseDisposeBagKey, defaultValue: {
                    DisposeBag()
                })
            }
        }

        set {
            synchronizedBag {
                objc_setAssociatedObject(base, &reuseDisposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }


}
