//
//  Routable.swift
//  ListFramework
//
//  Created by jie.xing on 2020/11/16.
//  Copyright © 2020 jie.xing. All rights reserved.
//

import UIKit

public protocol Scene: ViewController {
	
}

public protocol SceneAdapter {
	
	func transToScene() -> Scene
}

public protocol Navigable: ViewController {
	
	func push(to scene: SceneAdapter, animated: Bool)
	
	func present(to scene: SceneAdapter, modalPresentationStyle: UIModalPresentationStyle, animated: Bool)
}


public extension Navigable {
	
	func push(to scene: SceneAdapter, animated: Bool = true) {
		let scene = scene.transToScene()
		DispatchQueue.main.async { [weak self] in
			self?.navigationController?.pushViewController(scene, animated: animated)
		}
	}
	
	func present(to scene: SceneAdapter, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen, animated: Bool = true) {
		let scene = scene.transToScene()
		scene.modalPresentationStyle = modalPresentationStyle
		DispatchQueue.main.async { [weak self] in
			self?.present(scene, animated: animated, completion: nil)
		}
	}
	
	func pop<V: UIViewController>(to scene: V.Type? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
		if let scene = scene {
			guard let scene = navigationController?.viewControllerInStack(scene) else {
				fatalError()
			}
			DispatchQueue.main.async { [weak self] in
				self?.navigationController?.popToViewController(scene, animated: animated)
			}
		} else {
			DispatchQueue.main.async { [weak self] in
				self?.navigationController?.popViewController(animated: animated, completion)
			}
		}
	}
	
	func popToRoot(animated: Bool = true) {
		DispatchQueue.main.async { [weak self] in
			self?.navigationController?.popToRootViewController(animated: true)
		}
	}
}


extension ViewController: Navigable {}
extension ViewController: Scene {}
