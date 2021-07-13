//
//  HUDShowable.swift
//  Basic
//
//  Created by jie.xing on 2020/10/13.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import MBProgressHUD
import BasicFramework

public let hudAutoHidTimeInterval: TimeInterval = 2

public protocol HUDShowable {
    
    typealias HUD = MBProgressHUD
    
    typealias CompletionBlock = MBProgressHUDCompletionBlock
    
    var addedView: UIView {get}
    
    var hud: HUD {get}
        
    func showHUD(with text: String, completionBlock: CompletionBlock?)
    
    func showHUDAlways()
    
    func hiddenHUDAll()
}

public extension HUDShowable {
    
    func showHUD(with text: String, completionBlock: CompletionBlock? = nil) {
        hud.mode = .text
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: hudAutoHidTimeInterval)
        hud.completionBlock = completionBlock
    }

    func showHUDAlways() {
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
    }

    func hiddenHUDAll() {
        MBProgressHUD.forView(addedView)?.hide(animated: true)
    }

}

public extension HUDShowable where Self: ViewController {
    
    var addedView: UIView {
        self.view
    }

    var hud: HUD {
        let value: HUD
        if let already = HUD.forView(addedView) {
            value = already
        } else {
            value = HUD.showAdded(to: addedView, animated: true)
        }
        return value
    }
    
}
