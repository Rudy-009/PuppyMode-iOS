//
//  LoginViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/10/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        defineButtonActions()
    }
    
}

extension LoginViewController {
    private func defineButtonActions() {
        loginView.appleLoginButton.addTarget(self, action: #selector(popUpAppleLoginView), for: .touchUpInside)
        loginView.kakaoLoginButton.addTarget(self, action: #selector(popUpKakaoLoginView), for: .touchUpInside)
    }
    
    @objc
    private func popUpAppleLoginView() {
        
    }
    
    @objc
    private func popUpKakaoLoginView() {
        
    }
}
