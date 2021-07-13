//
//  DefaultError.swift
//  BasicFramework
//
//  Created by jie.xing on 2021/6/1.
//

import Foundation

public protocol DefaultError: Error {

    var localizedDescription: String {get}
}


