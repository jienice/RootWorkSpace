//
//  UINavigationController+Extensions.swift
//  ListFramework
//
//  Created by jie.xing on 2021/6/1.
//

import UIKit

extension UINavigationController {
    
    func viewControllerInStack<T: UIViewController>(_ type: T.Type) -> T? {
        guard !viewControllers.isEmpty else {
            return nil
        }
        return viewControllers.map { $0 as? T }.compactMap { $0 }.first
    }
}

