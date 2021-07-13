//
//  ImMessageCell.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/11.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit
import SnapKit
import ListFramework
import BasicFramework

protocol ImMessageCell: UIView {
    
    associatedtype Layout: ImMessageViewLayout

    var iconImage: UIImageView {get}

    var content: UIImageView {get}
    
    var layout: Layout? {get set}
}

// MARK: Property
fileprivate var iconImageKey: UInt8 = 0
fileprivate var contentKey: UInt8 = 0
extension ImMessageCell {

    var _layout: Layout {
        layout!
    }

    var iconImage: UIImageView {
        getAssociatedObjectIfNilSet(self, &iconImageKey, defaultValue: {
            let img = UIImageView()
            img.backgroundColor = .red
            img.borderColor = UIColor.green
            img.borderWidth = 1
            return img
        })
    }

    var content: UIImageView {
        getAssociatedObjectIfNilSet(self, &contentKey, defaultValue: {
            let img = UIImageView()
            img.backgroundColor = .red
            img.borderColor = UIColor.green
            img.borderWidth = 1
            return img
        })
    }
}

// MARK: Layout
extension ImMessageCell {

    func layoutDefaultViews() {
        switch _layout.alignment {
        case .other:
            iconImage.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(_layout.configuration.viewMargin.left)
                make.top.equalToSuperview().offset(_layout.configuration.viewMargin.top)
                make.size.equalTo(_layout.configuration.iconSize)
            }
            content.snp.remakeConstraints { make in
                make.left.equalTo(iconImage.snp.right).offset(_layout.configuration.viewElementSeparator)
                make.top.equalTo(iconImage.snp.top)
                make.width.equalTo(_layout.frame.width)
                make.bottom.equalTo(-_layout.configuration.viewMargin.bottom)
            }
        case .me:
            iconImage.snp.remakeConstraints { make in
                make.right.equalToSuperview().offset(-_layout.configuration.viewMargin.right)
                make.top.equalToSuperview().offset(_layout.configuration.viewMargin.top)
                make.size.equalTo(_layout.configuration.iconSize)
            }
            content.snp.remakeConstraints { make in
                make.right.equalTo(iconImage.snp.left).offset(-_layout.configuration.viewElementSeparator)
                make.top.equalTo(iconImage.snp.top)
                make.width.equalTo(_layout.frame.width)
                make.bottom.equalTo(-_layout.configuration.viewMargin.bottom)
            }
        }
    }

    func setTextNodeBkg() {
        switch _layout.alignment {
        case .other:
            content.image = UIImage.init(named: "otherTextNodeBkg")?
                    .resizableImage(withCapInsets: _layout.configuration.capInsets, resizingMode: .stretch)
                    .withRenderingMode(.alwaysTemplate)
        case .me:
            content.image = UIImage.init(named: "meTextNodeBkg")?
                    .resizableImage(withCapInsets: _layout.configuration.capInsets, resizingMode: .stretch)
                    .withRenderingMode(.alwaysTemplate)
        }
    }
}
