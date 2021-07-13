// 
//  Errors.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/30.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import BasicFramework

public enum Errors {
    
    enum Api: DefaultError {
        case noNetWork
        case timeOut
        case tokenInvalid
        case response(msg: String)

        public var localizedDescription: String {
            switch self {
            case .noNetWork:
                return "当前无网络"
            case let .response(msg):
                return msg
            case .timeOut:
                return "请求超时"
            case .tokenInvalid:
                return "Token 失效"
            }
        }
    }
    
    enum HUD: DefaultError {
        case showHUD
        case hidHUD
        public var localizedDescription: String {
            return ""
        }
    }
    
    enum Authorize: DefaultError {
        case photoAlbum
        case microphone
        case camera
        public var localizedDescription: String {
            switch self {
            case .photoAlbum:
                return "未授权读取相册"
            case .microphone:
                return "麦克风未授权"
            case .camera:
                return "摄像头未授权"
            }
        }
    }
    
    enum System: DefaultError {
        case runtime(msg: String)
        case custom(msg: String)

        public var localizedDescription: String {
            switch self {
            case let .custom(msg):
                return msg
            case let .runtime(msg):
                return msg
            }
        }
    }

}
