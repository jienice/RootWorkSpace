//
//  Refresh.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import MJRefresh

public final class HeaderRefresh: MJRefreshNormalHeader {
    
    public static func create(action: @escaping () -> Void) -> HeaderRefresh {
        let refresh = HeaderRefresh.init {
            action()
        }
        refresh.loadingView?.style = .medium
        refresh.lastUpdatedTimeLabel?.isHidden = true
        refresh.stateLabel?.isHidden = true
        return refresh
    }
}

public final class FooterRefresh: MJRefreshAutoNormalFooter {
    
    public static func create(action: @escaping () -> Void) -> FooterRefresh {
        let refresh = FooterRefresh.init {
            action()
        }
        return refresh
    }
}


