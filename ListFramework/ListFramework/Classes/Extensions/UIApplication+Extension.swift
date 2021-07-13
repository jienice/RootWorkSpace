// 
//  UIApplication+Extension.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/30.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func delegate<T: UIApplicationDelegate>(_ type: T.Type) -> T {
        UIApplication.shared.delegate as! T
    }

    static func topController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController {
        if let nav = base as? UINavigationController {
            return topController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topController(base: presented)
        }
        return base!
    }
}
