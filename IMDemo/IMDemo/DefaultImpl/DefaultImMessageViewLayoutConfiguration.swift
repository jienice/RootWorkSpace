//
//  DefaultImMessageViewLayoutConfiguration.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/21.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit

extension ImMessageViewLayoutConfiguration {
    
    var capInsets: UIEdgeInsets  {
        UIEdgeInsets.init(top: 30, left: 28, bottom: 85, right: 28)
    }

    var iconSize: CGSize {
        CGSize(width: 30, height: 30)
    }

    var viewElementSeparator: CGFloat {
        10
    }

    var viewMargin: UIEdgeInsets {
        UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }

    var viewMaxWidth: CGFloat {
        250
    }

    var contentMaxWidth: CGFloat {
        viewMaxWidth - iconSize.width - viewElementSeparator - viewMargin.left - viewMargin.right
    }

    func viewWidth(elementWidth: CGFloat) -> CGFloat {
        min(viewMaxWidth, viewMargin.left + iconSize.width + viewElementSeparator + elementWidth + viewMargin.right)
    }

}

extension TextMessageViewViewLayoutConfiguration {

    var textMargins: UIEdgeInsets {
        UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }

    var textMaxWidth: CGFloat {
        contentMaxWidth - textMargins.left - textMargins.right
    }

    func contentWidth(textWidth: CGFloat) -> CGFloat {
        min(textMaxWidth, textWidth + textMargins.left + textMargins.right)
    }
}


struct DefaultTextMessageViewViewLayoutConfiguration: TextMessageViewViewLayoutConfiguration {}


