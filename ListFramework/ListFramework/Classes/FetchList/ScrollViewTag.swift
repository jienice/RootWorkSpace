//
//  ScrollViewTag.swift
//  Basic
//
//  Created by jie.xing on 2020/10/15.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BasicFramework
import DZNEmptyDataSet
import MJRefresh

// MARK: ScrollViewTag
public protocol ScrollViewTag {
    
}

public enum RefreshStatus: ScrollViewTag {
    case noMore
    case empty
    case onlyOnePage
    case canLoadMore
    case error
}

public enum EmptyDataSet: ScrollViewTag {
    case empty
    case noNetWork
    case networkError
}

// MARK: EmptyDataSettable
fileprivate var emptyDataStatusKey: UInt8 = 0
public protocol EmptyDataSetSettable: ScrollView {
    
    var emptyDataStatus: EmptyDataSet? {get set}
    
    func updateEmptyDataSet()
}

public extension EmptyDataSetSettable {
    
    var emptyDataStatus: EmptyDataSet? {
        get { objc_getAssociatedObject(self, &emptyDataStatusKey) as? EmptyDataSet }
        set { objc_setAssociatedObject(self, &emptyDataStatusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func updateEmptyDataSet() {
        reloadEmptyDataSet()
    }
}

// MARK: RefreshStatusSettable
fileprivate var refreshStatusKey: UInt8 = 0
public protocol RefreshStatusSettable: ScrollView {
    
    var refreshStatus: RefreshStatus? {get set}
    
    func handleRefreshStatus()
}

public extension RefreshStatusSettable {
    
    var refreshStatus: RefreshStatus? {
        get { objc_getAssociatedObject(self, &refreshStatusKey) as? RefreshStatus }
        set { objc_setAssociatedObject(self, &refreshStatusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

public extension RefreshStatusSettable where Self: EmptyDataSetSettable {
    
    func handleRefreshStatus() {
        guard let refreshStatus = refreshStatus else { return }
        switch refreshStatus {
        case .canLoadMore:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
            mj_footer?.resetNoMoreData()
            mj_footer?.isHidden = false
        case .empty:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
            mj_footer?.isHidden = true
            emptyDataStatus = .empty
        case .noMore:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshingWithNoMoreData()
            mj_footer?.isHidden = false
        case .onlyOnePage:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshingWithNoMoreData()
            mj_footer?.isHidden = true
        case .error:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
        }
    }
}

// MARK: ScrollViewTagSettable
public protocol ScrollViewTagSettable: RefreshStatusSettable, EmptyDataSetSettable {
    
}

extension TableView: ScrollViewTagSettable {}

// MARK: ScrollViewTagSetTargetCatchier
public protocol ScrollViewTagSetTargetCatchier {
        
    var target: ScrollViewTagSettable? {get}
}

public protocol TableViewHolder {

    var tableView: TableView {get}
}

public extension ScrollViewTagSetTargetCatchier where Self: TableViewHolder {
    
    var target: ScrollViewTagSettable? {
        tableView
    }
}

// MARK: Rx
public extension Reactive where Base: RefreshStatusSettable {
    
    var refreshStatus: Binder<RefreshStatus?> {
        Binder(self.base) { target, status in
            guard let status = status else { return }
            target.refreshStatus = status
            target.handleRefreshStatus()
        }
    }
    
}

extension Reactive where Base: EmptyDataSetSettable {
    
    var emptyStatus: Binder<EmptyDataSet?> {
        Binder(self.base) { target, emptyStatus in
            target.emptyDataStatus = emptyStatus
        }
    }
}
