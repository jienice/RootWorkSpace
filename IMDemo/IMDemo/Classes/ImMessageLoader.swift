//
//  ImMessageLoader.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/8.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import BasicFramework

/// load message
protocol ImMessageLoader {
    
    associatedtype Input
        
    func fetchMessage(_ input: Input) -> [ImMessage]
}

/// load message from server
protocol NetworkImMessageLoader: ImMessageLoader {
    
}

/// load message from database
protocol DataBaseImMessageLoader: ImMessageLoader {
    
}
