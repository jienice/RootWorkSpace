//
//  Registrable.swift
//  ListFramework
//
//  Created by jie.xing on 2020/4/26.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import UIKit

public protocol Registrable {
    
}

public extension Registrable {
    
    static var identifier: String {
        String(describing: "\(self)")
    }
    
    static var nib: UINib? {
        UINib(nibName: "\(self)", bundle: nil)
    }
}

extension TableViewCell: Registrable {}
extension CollectionViewCell: Registrable {}
extension TableViewHeaderFooterView: Registrable {}

