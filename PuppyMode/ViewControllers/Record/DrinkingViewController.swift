//
//  DrinkingViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit

class DrinkingViewController: UIViewController {
    private let drinkingView = DrinkingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = drinkingView
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        drinkingView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        drinkingView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func plusButtonTapped() {
        let alcoholVC = AlcoholViewController()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(alcoholVC, animated: true)
    }

}
