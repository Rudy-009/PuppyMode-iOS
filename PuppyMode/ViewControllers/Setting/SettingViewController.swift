//
//  SettingViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import KakaoSDKUser

class SettingViewController: UIViewController {
    
    let settingView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = settingView
        defineButtonActions()
    }
}

extension SettingViewController {
    private func defineButtonActions() {
        self.settingView.termsOfServiceButton.addTarget(self, action: #selector(termsOfServiceButtonPressed), for: .touchUpInside)
        self.settingView.PrivacyPolicyButton.addTarget(self, action: #selector(privacyPolicyButtonPressed), for: .touchUpInside)
        self.settingView.revokeButton.addTarget(self, action: #selector(revokeButtonPressed), for: .touchUpInside)
        self.settingView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func termsOfServiceButtonPressed() {
        let viewControllerToPresent = SettingPopoverViewController()
        viewControllerToPresent.configurePopoverView(title: "이용약관", content: K.String.policy)
        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        viewControllerToPresent.modalTransitionStyle = .crossDissolve
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @objc
    private func privacyPolicyButtonPressed() {
        let viewControllerToPresent = SettingPopoverViewController()
        viewControllerToPresent.configurePopoverView(title: "개인정보 처리 방침", content: K.String.policy)
        viewControllerToPresent.modalPresentationStyle = .overFullScreen
        viewControllerToPresent.modalTransitionStyle = .crossDissolve
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @objc
    private func revokeButtonPressed() {
        let viewControllerToPresent = RevokeViewController()
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent,animated: true)
    }
    
    @objc
    private func logoutButtonPressed() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                self.changeRootToLoginViewController()
                print("logout() success.")
            }
        }
    }
    
    
    func changeRootToLoginViewController() {
        let baseViewController = LoginViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
    }
}

#Preview{
    SettingViewController()
}
