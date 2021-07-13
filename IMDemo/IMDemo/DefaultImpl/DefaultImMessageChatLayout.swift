//
//  DefaultImMessageChatLayout.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/8.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import CollectionKit
import SwifterSwift

class DefaultImMessageChatLayout: SimpleLayout, ImMessageChatLayout {
    
    override func simpleLayout(context: LayoutContext) -> [CGRect] {
        var frames: [CGRect] = []
        var lastLayout: ViewLayout?
        var lastFrame: CGRect?
        for i in 0..<context.numberOfItems {
            guard let layout = context.data(at: i) as? ViewLayout else {
                continue
            }
            guard layout.frame != .zero else {
                continue
            }
            var yHeight: CGFloat = 0
            var cellFrame = layout.frame
            cellFrame.size = CGSize(width: UIScreen.main.bounds.width, height: cellFrame.height)
            if let _ = lastLayout, let lastFrame = lastFrame {
                yHeight = lastFrame.maxY
            }
            cellFrame.origin.y = yHeight
            lastFrame = cellFrame
            lastLayout = layout
            frames.append(cellFrame)
        }
        return frames
    }
}


