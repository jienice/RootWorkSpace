// 
//  DefaultDataBaseImMessageLoader.swift
//  IMDemo
// 
//  Created by jie.xing on 2021/6/11.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

struct DefaultDataBaseImMessageLoader<Input>: DataBaseImMessageLoader {
    
    func fetchMessage(_ input: Input) -> [ImMessage] {
        [
            DefaultTextMessage.init(text: UUID().uuidString),
            DefaultTextMessage.init(text: UUID().uuidString),
            DefaultTextMessage.init(text: UUID().uuidString),
            DefaultTextMessage.init(text: UUID().uuidString),
            DefaultTextMessage.init(text: UUID().uuidString),
            DefaultTextMessage.init(text: UUID().uuidString)
        ]
    }
}
