//
//  ListViewController.swift
//  FrameworkDemo
//
//  Created by jie.xing on 2021/7/14.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit
import ListFramework

class ListViewController: ViewController, ViewControllerBehaviours {

    lazy var table = TableView.init(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
}

extension ListViewController {
    

    func setupViews() {
        view.addSubviews([table])
    }
    
}
