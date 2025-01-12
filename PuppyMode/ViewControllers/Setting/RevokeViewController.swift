//
//  RevokeViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit

class RevokeViewController: UIViewController {
    
    let revokeView = RevokeView()

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
    }
}
