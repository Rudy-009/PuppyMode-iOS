//
//  IntakeViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 24/01/2025.
//

import UIKit

class IntakeViewController: UIViewController {
    private let intakeView = IntakeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = intakeView
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        intakeView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
