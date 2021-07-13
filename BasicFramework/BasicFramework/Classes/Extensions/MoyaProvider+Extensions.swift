//
//  MoyaProvider+Extensions.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/6/17.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Moya

public extension MoyaProvider {

    static func defaultPlugins() -> [PluginType] {
        let networkActivityPlugin = NetworkActivityPlugin.init(networkActivityClosure: { type, _ in
            DispatchQueue.main.async {
                //TODO: change
                UIApplication.shared.isNetworkActivityIndicatorVisible = (type == .began)
            }
        });
            
        let loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: [.successResponseBody, .errorResponseBody, .requestBody, .requestMethod]))
        return [networkActivityPlugin, loggerPlugin];
    }
}
