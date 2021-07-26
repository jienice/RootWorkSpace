//
//  PopoverViewController.swift
//  FrameworkDemo
//
//  Created by jie.xing on 2021/7/14.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import UIKit
import ListFramework

class PopoverViewController: ViewController, ViewControllerBehaviours {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }

}

extension PopoverViewController {
    
    func setupViews() {
        view.backgroundColor = .white
    }
}
