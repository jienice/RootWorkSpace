//
//  Kingfisher+Rx.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/5/28.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

extension ImageCache: ReactiveCompatible {}

extension Reactive where Base: ImageCache {

    func retrieveCacheSize() -> Observable<Int> {
        Single.create { single in
            base.calculateDiskStorageSize { (result) in
                do {
                    single(.success(Int(try result.get())))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
        }.asObservable()
    }

    public func clearCache() -> Observable<Void> {
        Single.create { single in
            base.clearMemoryCache()
            base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create { }
        }.asObservable()
    }
}
