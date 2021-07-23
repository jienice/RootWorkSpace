//
//  FrameworkScene.swift
//  FrameworkDemo
//
//  Created by jie.xing on 2021/7/14.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import ListFramework

enum FrameworkScene: SceneAdapter {
    case popover
    case record
    
    func transToScene() -> Scene {
        switch self {
        case .popover:
            return PopoverViewController()
        case .record:
            return RecordViewController()
        }
    }
}
