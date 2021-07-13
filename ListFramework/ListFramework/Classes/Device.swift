//
//  Device.swift
//  ListFramework
//
//  Created by jie.xing on 2020/4/28.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import DeviceKit

public extension Device {
	
	static var statusBar: CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarSize = window?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize.zero
		return min(statusBarSize.width, statusBarSize.height)
	}
	
}
