//
//  PrimitiveSequence+Extensions.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/6/4.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {

    func mapSwiftyJSON() -> Single<JSON> {
        return mapJSON()
            .map{ JSON($0) }
    }
    
    func mapResponse<R: BasicFramework.Response>(_ response: R.Type) -> Single<R> {
        return mapSwiftyJSON()
            .map { response.create(from: $0) }
    }

    
    func mapResponse<R: BasicFramework.Response, L: BasicFramework.List>(_ response: R.Type, _ list: L.Type) -> Single<L> {
        return mapResponse(response)
            .map{ list.create(from: $0.data) }
    }
    
}


//
//public extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
//
//    func mapResponse() -> PrimitiveSequence<Trait, Response> {
//        return self.filter(statusCode: 200).mapJSON().map { Response.create(from: JSON($0)) }
//    }
//}
//
//public extension Observable where Element == List {
//
//    func mapDataSource(alreadyHave: BehaviorRelay<[JSON]>) -> Observable<[JSON]> {
//        return self.map {
//            guard $0.pageNum != List.errorPageNum else {
//                return alreadyHave.value
//            }
//            if $0.pageNum == 1 {
//                return $0.list
//            } else {
//                return alreadyHave.value + $0.list
//            }
//        }
//    }
//
//}


//public extension Observable {
//
//    func ifError(do: @escaping (Swift.Error) -> Void) -> Observable<Element> {
//        return self.do(onError: {
//            `do`($0)
//        })
//    }
//
//    func mapOptional() -> Observable<Element?> {
//        return map { element -> Element? in element }
//    }
//
//    func trackEvent<R>(_ emitter: R?, hud: Bool = false) -> Observable where R: ErrorEmittable {
//        return self.do(onNext: { [weak emitter] _ in
//            guard hud else { return }
//            emitter?.emit(with: DefaultError.hidHUD)
//        }, onError: { [weak emitter] in
//            emitter?.emit(with: $0)
//        }, onCompleted: {
//
//        }, onSubscribed: { [weak emitter] in
//            guard hud else { return }
//            emitter?.emit(with: DefaultError.showHUD)
//        }, onDispose: {
//
//        })
//    }
//
//    /**
//     当请求返回401时调用刷新token接口，当接口返回后再重试当前请求。
//     目前仅支持单个请求、使用`zip`包裹的多个请求。
//     warning: 如果要使用本方法，同时发起多个请求时必须使用`zip`
//    */
//    func retryWhenTokenInvalid<R: OAuth>(refreshToken: R) -> Observable<Element> {
//        return self.retryWhen { input -> Observable<Notification> in
//            return input.enumerated().flatMapLatest { (_, error: DefaultError) -> Observable<Notification> in
//                if let statusCode = (error as? MoyaError)?.response?.statusCode, statusCode == 401 {
//                    refreshToken.refreshTokenFromService()
//                    return Observable<Notification>.merge(
//                        NotificationCenter.default.rx.notification(BasicNotification.RefreshTokenFail)
//                            .map { $0.object as? DefaultError }.filterNil()
//                            .flatMap { Observable<Notification>.error($0) },
//                        NotificationCenter.default.rx.notification(BasicNotification.RefreshTokenSuccess))
//                } else {
//                    return Observable<Notification>.error(error)
//                }
//            }
//        }
//    }
//}



//
//public extension Observable {
//
//    static func createResultList<T: TargetType, R: BasicFramework.Response>(provider: MoyaProvider<T>, response: R.Type, token: T) -> Observable<List> {
//        return Observable<List>.create { (observer) -> Disposable in
//            return provider.rx.request(token)
//                .mapResponse(response)
//
//                .subscribe(onSuccess: { response in
//                    if let error = response.error {
//                        observer.onError(error)
//                    } else {
//                        observer.onNext(List.create(from: response.data))
//                        observer.onCompleted()
//                    }
//                }, onError: {
//                    observer.onError($0)
//                })
//        }
//    }
//
//    static func creatResultJSON<T: TargetType>(provider: MoyaProvider<T>, token: T) -> Observable<JSON> {
//        return Observable<JSON>.create({ observer -> Disposable in
//            return provider.rx.request(token)
//                .mapResponse()
//                .subscribe(onSuccess: { response in
//                    if let error = response.error {
//                        observer.onError(error)
//                    } else {
//                        observer.onNext(response.data)
//                        observer.onCompleted()
//                    }
//                }, onError: {
//                    observer.onError($0)
//                })
//
//        })
//    }
//
//
//    static func creatResultArray<T: TargetType>(provider: MoyaProvider<T>, token: T) -> Observable<[JSON]> {
//        return Observable<[JSON]>.create({ observer -> Disposable in
//            return provider.rx.request(token)
//                .mapResponse()
//                .subscribe(onSuccess: { response in
//                    if let error = response.error {
//                        observer.onError(error)
//                    } else {
//                        observer.onNext(response.data.arrayValue)
//                        observer.onCompleted()
//                    }
//                }, onError: {
//                    observer.onError($0)
//                })
//
//        })
//    }
//
//    static func createResultAction<T: TargetType>(provider: MoyaProvider<T>, token: T) -> Observable<Bool> {
//        return Observable<Bool>.create({ observer -> Disposable in
//            return provider.rx.request(token)
//                .mapResponse()
//                .subscribe(onSuccess: { response in
//                    if let error = response.error {
//                        observer.onError(error)
//                    } else {
//                        observer.onNext(true)
//                        observer.onCompleted()
//                    }
//                }, onError: {
//                    observer.onError($0)
//                })
//        })
//    }
//
//}
