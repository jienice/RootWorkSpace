//
//  NotificationConvertible.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/6/4.
//

import Foundation

public protocol NotificationConvertible {

    var notification: Notification {get}
}

public extension NotificationConvertible {

    var name: Notification.Name {
        Notification.Name.init(String(describing: "\(self)"))
    }
    
}

