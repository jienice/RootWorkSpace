// 
//  RxErrorAdapter.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation
import RxSwift
import BasicFramework

struct RxErrorAdapter: ErrorAdaptable {

    let error: RxError

    func trans() -> DefaultError? {
        switch error {
        case .timeout:
            return Errors.Api.timeOut
        default:
            return Errors.Api.response(msg: error.localizedDescription)
        }
    }

}
