//
//  SettingViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

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
        self.settingView.termsOfServiceAndPrivacyPolicyButton.addTarget(self, action: #selector(policyButtonPressed), for: .touchUpInside)
        self.settingView.revokeButton.addTarget(self, action: #selector(revokeButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func policyButtonPressed() {
        print("Policy Button Pressed")
    }
}

//MARK: Revoke Account
extension SettingViewController {
    @objc
    private func revokeButtonPressed() {
        print("Revoke Button Pressed")
    }
}

#Preview{
    SettingViewController()
}
