//
//  RootViewControllerManager.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Foundation
import UIKit

class RootViewControllerService {
    private static let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    private static let loginViewController = LoginViewController()
    private static let baseViewController = BaseViewController()
    private static let puppySelectionViewController = PuppySelectionViewController()
    
    static func toBaseViewController() {
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
    }
    
    static func toPuppySelectionViewController() {
        sceneDelegate?.changeRootViewController(puppySelectionViewController, animated: false)
    }
    
    static func toLoginViewController() {
        sceneDelegate?.changeRootViewController(loginViewController, animated: false)
    }
}
