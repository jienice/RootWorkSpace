//
//  ErrorEmittable.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/6/1.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

fileprivate var errorKey: UInt8 = 0

public protocol ErrorEmittable: Object {
    
    var error: BehaviorRelay<DefaultError?> {get}
    
    var errorDisposeBag: DisposeBag {get}
    
    func bindErrorHandler(handler: ErrorHandleable)
}


public protocol BeforeErrorEmit {
    
    func acceptedErrorSideEffect(error: DefaultError)
}


public protocol AfterErrorEmitted {
    
    func acceptedErrorSideEffect(error: DefaultError)
}


public extension ErrorEmittable {
    
    var error: BehaviorRelay<Error?> {
        getAssociatedObjectIfNilSet(self, &errorKey) {
            BehaviorRelay<Error?>.init(value: nil)
        }
    }
    
    var errorDisposeBag: DisposeBag {
        rx.disposeBag
    }
    
    func emit(_ error: Error) {
        
    }
    
    func bindErrorHandler(handler: ErrorHandleable) {
        error
            .filterNil()
            .subscribe(onNext: { [weak handler] in
                handler?.handleError(error: $0)
            }).disposed(by: errorDisposeBag)
    }
    
}

