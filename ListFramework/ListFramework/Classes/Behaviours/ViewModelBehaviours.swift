// 
//  ViewModelBehaviours.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

public protocol ViewModelBehaviours: ViewModel {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

