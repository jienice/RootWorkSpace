// 
//  MoyaErrorAdapter.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import Moya
import BasicFramework
import SwiftyJSON

struct MoyaErrorAdapter: ErrorAdaptable {

    let error: MoyaError

    func trans() -> DefaultError? {
        switch error {
        case let .underlying(error, _):
            if let error = error.asAFError {
                return  AFErrorAdapter.init(error: error).trans()
            } else {
                return Errors.System.custom(msg: error.localizedDescription)
            }
        case let .statusCode(response):
            guard response.statusCode != 200 else {
                return nil
            }
            guard let msg = JSON(response.data)["msg"].string else {
                return nil
            }
            return Errors.Api.response(msg: msg)
        default:
            return Errors.Api.response(msg: error.localizedDescription)
        }
    }
}
