// 
//  FetchListtable.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import BasicFramework
import RxCocoa
import SwiftyJSON
import Action

fileprivate var dataSourceKey: UInt8 = 0

public protocol FetchListtable: PageSettable, RefreshStatusSendable {

    var dataSource: BehaviorRelay<[JSON]> {get}

    var fetchDisposeBag: DisposeBag {get}
}

public extension FetchListtable {

    var dataSource: BehaviorRelay<[JSON]> {
        getAssociatedObjectIfNilSet(self, &dataSourceKey) {
            BehaviorRelay<[JSON]>(value: [JSON]())
        }
    }
}

public extension FetchListtable where Self: ErrorEmittable {

    /// 用户请求单页数据
    /// - Parameters:
    ///   - headerRefresh: 头部刷新
    ///   - endpoint: 请求api，方法内部已进行catchError
    func bindFetchOnlyOnepageSingleAccordingToInput(headerRefresh: CocoaAction, endpoint: @escaping () -> Observable<[JSON]>) {
        headerRefresh
                .executionObservables
                .switchLatest()
                .flatMapLatest { [weak self] in
                    endpoint()
                            .do(onNext: {
                                self?.send($0.isEmpty ? .empty: .onlyOnePage)
                            }, onError: {
                                self?.send(.error)
                                self?.emit($0)
                            })
                            .catchErrorJustReturn([JSON]()) }
                .bind(to: dataSource)
                .disposed(by: fetchDisposeBag)

    }

    /// 主要用于分页请求功能
    /// - Parameters:
    ///   - headerRefresh: 头部刷新
    ///   - footerRefresh: 脚部刷新
    ///   - endpoint: 请求api，方法内部已进行catchError
    func bindFetchListSingleAccordingToInput(headerRefresh: CocoaAction, footerRefresh: CocoaAction,
                                             endpoint: @escaping (Int) -> Observable<List>) {
        let refresh =
                Observable.merge([
                    headerRefresh
                            .executionObservables
                            .switchLatest()
                            .map { [weak self] in self?.resetPage() }
                            .filterNil(),
                    footerRefresh
                            .executionObservables
                            .switchLatest()
                            .map { [weak self] in self?.increasePage() }
                            .filterNil()])

        refresh
                .flatMapLatest {
                    endpoint($0)
                }
                .mapDataSource(alreadyHave: dataSource.value)
                .bind(to: dataSource)
                .disposed(by: fetchDisposeBag)
    }

    /// 主要用于分页+搜索功能
    /// - Parameters:
    ///   - headerRefresh: 头部刷新
    ///   - footerRefresh: 脚部刷新
    ///   - searchKey: 搜索输入信号
    ///   - endpoint: 请求api，方法内部已进行catchError
    /// - Returns: 清空搜索输入
    func bindSearchFetchListSingleAccordingToInput(headerRefresh: CocoaAction,
                                                   footerRefresh: CocoaAction,
                                                   cancelSearch: CocoaAction,
                                                   searchKey: Observable<String?>,
                                                   endpoint: @escaping (Int, String?) -> Observable<List>) -> CocoaAction {
        let searchKeyword = BehaviorRelay<String?>(value: nil)

        let outputHeaderRefresh = CocoaAction.create()

        Observable.merge(cancelSearch.executionObservables.switchLatest().map { nil }, searchKey)
                .bind(to: searchKeyword)
                .disposed(by: fetchDisposeBag)

        let refresh =
                Observable.merge([
                    headerRefresh
                            .executionObservables
                            .switchLatest()
                            .map { [weak self] in self?.resetPage() }
                            .filterNil(),
                    footerRefresh
                            .executionObservables
                            .switchLatest()
                            .map { [weak self] in self?.increasePage() }
                            .filterNil()])

        refresh
                .flatMapLatest {
                    endpoint($0, searchKeyword.value)
//                    .ifError { _ in self?.decreasePage() }
//                    .trackEvent(self)
//                    .catchErrorJustReturn(List.error()) }
//            .do(onNext: { [weak self] in
//                self?.refreshStatus.accept($0.refreshStatus)
//            })
                }
                .mapDataSource(alreadyHave: dataSource.value)
                .bind(to: dataSource)
                .disposed(by: fetchDisposeBag)

        Observable.merge(cancelSearch.executionObservables.switchLatest(), searchKey.filterNil().mapTo(()))
                .subscribe(onNext: {
                    outputHeaderRefresh.execute()
                }).disposed(by: fetchDisposeBag)

        return outputHeaderRefresh
    }
}

public extension FetchListtable where Self: Object {

    var fetchDisposeBag: DisposeBag {
        rx.disposeBag
    }
}


extension Observable where Element == List {

    func mapDataSource(alreadyHave: [JSON]) -> Observable<[JSON]> {
        // TODO:
        map(\.dataSource).map{$0 + alreadyHave}
    }
}