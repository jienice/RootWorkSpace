// 
//  DefaultTextMessageViewLayout.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/9.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import SwifterSwift

struct DefaultTextMessageViewLayout: ImMessageViewLayout {
    
    typealias Message = DefaultTextMessage
    
    typealias Configuration = DefaultTextMessageViewViewLayoutConfiguration

    var configuration = DefaultTextMessageViewViewLayoutConfiguration()
    
    var innerMessage: Message
    
    var alignment: ImMessageAlignment {
        //todo
        if innerMessage.text.hashValue % 2 == 0 {
            return .me
        } else {
            return .other
        }
    }

    var frame: CGRect {
        //todo calculate size
        let textWidth: CGFloat = 200
        let elementWidth = configuration.contentWidth(textWidth: textWidth);
        let w = configuration.viewWidth(elementWidth: elementWidth);
        return CGRect.init(x: 0, y: 0, width: w, height: 60)
    }

}
