// 
//  ViewBehaviours.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit

public protocol ViewBehaviours: View {

    associatedtype Element

    func config(with element: Element)
}

public protocol ViewHeightCalculable: ViewBehaviours {

    associatedtype Margins
    associatedtype Fonts
    
    static func calculateViewHeight(with element: Element) -> CGFloat
}

public protocol ViewHeightGettable: ViewBehaviours {

    static var viewHeight: CGFloat {get}
}
