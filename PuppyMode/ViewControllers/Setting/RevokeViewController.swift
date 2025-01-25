//
//  RevokeViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit
import KakaoSDKUser

class RevokeViewController: UIViewController {
    
    private lazy var revokeView = RevokeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = revokeView
        defineButtonActions()
    }
    
}

extension RevokeViewController {
    
    private func defineButtonActions() {
        revokeView.popButton.addTarget(self, action: #selector(popButtonPressed), for: .touchUpInside)
        revokeView.revokeButton.addTarget(self, action: #selector(revokeButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func popButtonPressed() {
        print("Pop Button Pressed")
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Revoke Account
extension RevokeViewController {
    
    @objc
    private func revokeButtonPressed() {
        print("Revoke Button Pressed")
        
        if let _ = KeychainService.get(key: K.String.kakaoUserID) {
            if KeychainService.delete(key: K.String.kakaoUserID) {
                self.kakaoRevoke()
            }
        }
    }
    
    private func kakaoRevoke() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                self.changeRootToLoginViewController()
                print("unlink() success.")
            }
        }
    }
    
    private func changeRootToLoginViewController() {
        let baseViewController = LoginViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
    }
}
