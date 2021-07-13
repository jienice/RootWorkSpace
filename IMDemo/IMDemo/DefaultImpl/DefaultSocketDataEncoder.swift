//
//  DefaultSocketDataEncoder.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/10.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation

struct DefaultSocketDataEncoder: SocketDataEncoder {
    
    func encode(message: ImMessage) -> SocketSendElement? {
        guard let text =  (message as? TextMessage)?.text else {
            return nil
        }
        guard let data = Data(base64Encoded: text) else {
            return nil
        }
        return DefaultSocketSendElement.init(data: data)
    }
}
