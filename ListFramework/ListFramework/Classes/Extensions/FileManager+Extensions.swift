// 
//  FileManager+Extensions.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import Foundation

extension FileManager {

    func directoryIsExistsIfNotCreate(at path: String) {
        guard !FileManager.default.fileExists(atPath: path) else { return }
        try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
    }
}