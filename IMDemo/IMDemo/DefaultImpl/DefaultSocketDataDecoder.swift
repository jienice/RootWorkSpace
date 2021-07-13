//
//  DefaultSocketDataDecoder.swift
//  IMDemo
//
//  Created by jie.xing on 2021/6/10.
//  Copyright © 2021 jie.xing. All rights reserved.
//

import Foundation
import SwifterSwift

struct DefaultSocketDataDecoder: SocketDataDecoder {
    
    func decode(data: SocketSendElement) -> ImMessage? {
        let text = data.data.base64EncodedString()
        return DefaultTextMessage.init(text: text)
    }

}
