//
//  HangoverViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 15/01/2025.
//

import UIKit

class HangoverViewController: UIViewController {
    private let hangoverView = HangoverView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = hangoverView
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        hangoverView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
