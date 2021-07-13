// 
//  Popver.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/7/12.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import Popover
import BasicFramework
import RxDataSources
import SwifterSwift

public protocol PopoverShowable {

    associatedtype PopoverItemType: PopoverItem
    
    var popover: PopoverView<PopoverItemType> {get}
}

public protocol PopoverItem {
    
    var title: String {get}
}

public protocol PopoverConfiguration: Configuration {
    
    var cellHeight: CGFloat {get}
    
    var popoverOptions: [PopoverOption] {get}
}


public class PopoverView<Item: PopoverItem>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public typealias ItemSelectedHandler = (Item) -> Void
    
    lazy var tableView: UITableView = {
        let tab = UITableView(frame: CGRect.zero, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tab
    }()

    var didSelectedItemHandler: ItemSelectedHandler?

    var dataSource: [Item] = [Item]() {
        didSet{
            if dataSource.count > 6 {
                tableView.isScrollEnabled = true
                tableView.height = configuration.cellHeight * CGFloat(6)
            }else{
                tableView.isScrollEnabled = false
                tableView.height = configuration.cellHeight * CGFloat(dataSource.count)
            }
            tableView.width = 100
            tableView.reloadData()
        }
    }

    lazy var pop: Popover = Popover(options: configuration.popoverOptions)

    public let configuration: PopoverConfiguration
    
    public init(configuration: PopoverConfiguration) {
        self.configuration = configuration
        super.init()
    }

    public func showPopover(_ dataSource: [Item], from view: UIView, selectedHandler: ItemSelectedHandler?) {
        self.dataSource = dataSource
        didSelectedItemHandler = selectedHandler
        pop.show(tableView, fromView: view)
    }

    //MARK: UITableViewDataSource, UITableViewDelegate
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configuration.cellHeight
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withClass: TableViewCell.self, for: indexPath)
        cell.textLabel?.text = type.title
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pop.dismiss()
        let item = dataSource[indexPath.row]
        if let handler = didSelectedItemHandler {
            DispatchQueue.main.async {
                handler(item)
            }
        }
    }

}
