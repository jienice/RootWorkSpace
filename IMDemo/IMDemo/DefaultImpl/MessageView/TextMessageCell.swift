//
//  TextMessageCell.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/11.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit

class TextMessageCell: UIView, ImMessageCell {

    typealias Layout = DefaultTextMessageViewLayout

    var layout: Layout? {
        didSet {
            textLab.text = _layout.innerMessage.text
        }
    }

    lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.textColor = DefaultThemeConfiguration.color.title
        lab.font = DefaultThemeConfiguration.font.title
        lab.borderColor = DefaultThemeConfiguration.color.border
        lab.borderWidth = 0.4
        return lab
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .yellow
        addSubviews([iconImage, content])
        content.addSubview(textLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutDefaultViews()
        textLab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(_layout.configuration.textMargins)
        }
    }
    
}
