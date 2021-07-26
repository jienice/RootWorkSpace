//
//  ViewController.swift
//  FrameworkDemo
//
//  Created by jie.xing on 2021/6/1.
//

import UIKit
import BasicFramework
import ListFramework
import RxDataSources
import RxSwift
import RxCocoa

class RootViewController: ViewController, ViewControllerBehaviours {
    
    @PlistValue<String>(key: "name")
    var name

    enum RowType {
        case popover
        case record
        case list
        case error

        var text: String {
            switch self {
            case .popover:
                return "Popover"
            case .record:
                return "Record"
            case .list:
                return "Table"
            case .error:
                return "Error"
            }
        }
    }
    
    lazy var table: TableView = {
        let table = TableView.init(frame: view.bounds)
        table.register(cellWithClass: TableViewCell.self)
        return table
    }()
    
    lazy var dataSource = BehaviorRelay<[RowType]>(value: [RowType]())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        dataSource.accept([.popover, .record, .list, .error])
    }
    
    func bindViewModel() {
        dataSource
                .bind(to: table.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self))
                { (index, element, cell) in
                    cell.textLabel?.text = element.text
                }.disposed(by: rx.disposeBag)
        
        table.rx.itemSelected
            .map { [weak self] in self?.dataSource.value[$0.row] }
            .filterNil()
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .popover:
                    self?.push(to: FrameworkScene.popover)
                case .record:
                    self?.push(to: FrameworkScene.record)
                case .list:
                    self?.push(to: FrameworkScene.list)
                default:
                    fatalError()
                }
            }).disposed(by: rx.disposeBag)
    }

}

extension RootViewController {
    
    func setupViews() {
        title = "RootViewController"
        view.addSubviews([table])
    }
    
}

