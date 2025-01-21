//
//  AlcoholViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit

class AlcoholViewController: UIViewController {
    private let alcoholView = AlcoholView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = alcoholView
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        alcoholView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
