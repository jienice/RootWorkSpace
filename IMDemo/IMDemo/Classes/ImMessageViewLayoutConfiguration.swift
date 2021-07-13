// 
//  ImMessageViewLayoutConfiguration.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/21.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import BasicFramework
/**
 ------------------------------------------------------------------
 |                          viewMargin.top                        |
 |                  |----|--|-------------------|                 |
 |                  |icon|  |                   |                 |
 | viewMargin.left  |----|--|      Content      |viewMargin.right |
 |                  |       |                   |                 |
 |                  |       |-------------------|                 |
 |                  |                           |                 |
 |                  |---------------------------|                 |
 |                         viewMargin.bottom                      |
 ------------------------------------------------------------------
 ElementSize -> ContentSize -> ViewSize
 */
protocol ImMessageViewLayoutConfiguration: Configuration {

    var capInsets: UIEdgeInsets {get}

    /// Icon size
    var iconSize: CGSize {get}

    /// View elements horizontal separator
    var viewElementSeparator: CGFloat {get}

    /// Message view margins
    var viewMargin: UIEdgeInsets {get}

    /// Message view max width
    var viewMaxWidth: CGFloat {get}

    /// Message content max width
    var contentMaxWidth: CGFloat {get}

    /// Calculate message view width
    func viewWidth(elementWidth: CGFloat) -> CGFloat
}

protocol TextMessageViewViewLayoutConfiguration: ImMessageViewLayoutConfiguration {

    var textMargins: UIEdgeInsets {get}

    var textMaxWidth: CGFloat {get}

    func contentWidth(textWidth: CGFloat) -> CGFloat
}