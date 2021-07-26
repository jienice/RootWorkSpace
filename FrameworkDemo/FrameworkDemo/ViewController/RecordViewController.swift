// 
//  RecordViewController.swift
//  FrameworkDemo
// 
//  Created by jie.xing on 2021/7/14.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import ListFramework

class RecordViewController: ViewController, ViewControllerBehaviours {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
}


extension RecordViewController {
    
    func setupViews() {
        view.backgroundColor = .white
    }
}
