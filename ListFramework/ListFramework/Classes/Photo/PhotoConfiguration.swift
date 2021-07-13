// 
//  PhotoConfiguration.swift
//  ListFramework
// 
//  Created by jie.xing on 2021/5/31.
//  Copyright (c) 2021 jie.xing. All rights reserved.
//

import UIKit
import BasicFramework

public protocol PhotoConfiguration: Configuration {

    var videoDirectory: String{get}

    var imageDirectory: String{get}

    var compressionQuality: CGFloat {get}
}

extension PhotoConfiguration {

    var imageFilePath: String {
        imageDirectory + "/" + UUID().uuidString + ".jpeg"
    }

    var videoFilePath: String {
        videoDirectory + "/" + UUID().uuidString + ".mp4"
    }
}



