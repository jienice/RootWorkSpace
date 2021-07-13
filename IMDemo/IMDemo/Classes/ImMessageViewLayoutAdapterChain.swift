// 
//  ImMessageViewLayoutAdapterChain.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/7/8.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

protocol ImMessageViewLayoutAdapterChain {

    func adapt(message: ImMessage) -> ViewLayout
}