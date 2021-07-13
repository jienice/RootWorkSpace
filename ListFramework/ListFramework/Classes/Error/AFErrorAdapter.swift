// 
//  AFErrorAdapter.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import Alamofire
import BasicFramework

struct AFErrorAdapter: ErrorAdaptable {

    let error: AFError

    func trans() -> DefaultError? {
        switch error {
        case let .sessionTaskFailed(error):
            return Errors.Api.response(msg: error.localizedDescription)
        case .explicitlyCancelled:
            return nil
        default:
            return Errors.Api.response(msg: error.localizedDescription)
        }
    }
}
