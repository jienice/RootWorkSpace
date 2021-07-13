//
//  XLForm+Extensions.swift
//  Basic
//
//  Created by jie.xing on 2020/6/8.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import XLForm
import BasicFramework

public protocol FormThemeConfiguration: Configuration {

    static var color: ColorConfiguration {get}
    static var font: FontConfiguration {get}
    static var accessoryView: UIImage? {get}
}


public extension XLFormRowDescriptor {
    
    func typeTextCellConfig<C: FormThemeConfiguration>(title: String, placeholder: String? = nil, configuration: C.Type) {
        self.title = title
        if let placeholder = placeholder {
            let attributedPlaceholder = NSAttributedString(string: placeholder,
                                                           attributes: [.foregroundColor: configuration.color.placeholder])
            cellConfig["textField.attributedPlaceholder"] = attributedPlaceholder
        }
        cellConfig["textLabel.textColor"] = configuration.color.title
        cellConfig["textField.textColor"] = configuration.color.detail
        cellConfig["textLabel.font"] = configuration.font.title
        cellConfig["textField.font"] = configuration.font.detail
        cellConfig["backgroundColor"] = configuration.color.background
        cellConfig["textField.textAlignment"] = NSTextAlignment.right.rawValue
        cellConfig["selectionStyle"] = UITableViewCell.SelectionStyle.none.rawValue
    }
    
    func typeDateCellConfig<C: FormThemeConfiguration>(title: String, placeholder: String? = nil, configuration: C.Type) {
        self.title = title
        self.noValueDisplayText = placeholder
        cellConfig["maximumDate"] = Date()
        cellConfig["textLabel.textColor"] = configuration.color.title
        cellConfig["textLabel.font"] = configuration.font.title
        cellConfig["detailTextLabel.font"] = configuration.font.detail
        cellConfig["detailTextLabel.textColor"] = configuration.color.detail
        cellConfig["backgroundColor"] = configuration.color.background
        cellConfig["selectionStyle"] = UITableViewCell.SelectionStyle.none.rawValue
        cellConfig["accessoryView"] = configuration.accessoryView?.template
        cellConfig["accessoryView.tintColor"] = configuration.color.primary
        cellConfig["datePicker.preferredDatePickerStyle"] = UIDatePickerStyle.wheels.rawValue
    }
    
    func typeSelectorCellConfig<C: FormThemeConfiguration>(title: String, noValueDisplayText: String? = nil, configuration: C.Type) {
        self.title = title
        self.noValueDisplayText = noValueDisplayText
        cellConfig["textLabel.textColor"] = configuration.color.title
        cellConfig["detailTextLabel.textColor"] = configuration.color.detail
        cellConfig["textLabel.font"] = configuration.font.title
        cellConfig["detailTextLabel.font"] = configuration.font.detail
        cellConfig["backgroundColor"] = configuration.color.background
        cellConfig["detailTextLabel.textAlignment"] = NSTextAlignment.right.rawValue
        cellConfig["selectionStyle"] = UITableViewCell.SelectionStyle.none.rawValue
        cellConfig["accessoryView"] = configuration.accessoryView?.template
        cellConfig["accessoryView.tintColor"] = configuration.color.primary
    }
}
