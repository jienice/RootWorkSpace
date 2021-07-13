//
//  NetworkReachability.swift
//  BasicFramework
//
//  Created by jie.xing on 2020/8/31.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

public class NetworkReachability {
    
    public enum Status {
        case unknown
        case notReachable
        case ethernetOrWiFi
        case cellular
    }
    
    let reachability = NetworkReachabilityManager.default
    
    public static let `default` = NetworkReachability()
    
    public let status = BehaviorRelay<Status>(value: .unknown)
    
    public func startListening() {
        reachability?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { [weak self] in
            switch $0 {
            case .notReachable:
                self?.status.accept(.notReachable)
            case .unknown:
                self?.status.accept(.unknown)
            case let .reachable(type):
                switch type {
                case .cellular:
                    self?.status.accept(.cellular)
                case .ethernetOrWiFi:
                    self?.status.accept(.ethernetOrWiFi)
                }
            }
        })
    }
}


