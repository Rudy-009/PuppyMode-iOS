//
//  PuppySelectionViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/26/25.
//

import UIKit

class PuppySelectionViewController: UIViewController {

    private let puppySelectionView = PuppySelectionView()
    private let confirmVC = PuppySelectionConfirmViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = puppySelectionView
        self.view.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        connectButtonActions()
    }
    
    private func connectButtonActions() {
        puppySelectionView.bichonButton.addTarget(self, action: #selector(bichonButtonPressed), for: .touchUpInside)
        puppySelectionView.welshCorgiButton.addTarget(self, action: #selector(welshCorgiButtonPressed), for: .touchUpInside)
        puppySelectionView.pomeranianButton.addTarget(self, action: #selector(pomeranianButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func bichonButtonPressed() {
        confirmVC.configure(puppy: .babyBichon)
        showConfirmVC()
    }
    
    @objc
    private func welshCorgiButtonPressed() {
        confirmVC.configure(puppy: .babyWelshCorgi)
        showConfirmVC()
    }
    
    @objc
    private func pomeranianButtonPressed() {
        confirmVC.configure(puppy: .babyPomeranian)
        showConfirmVC()
    }
    
    private func showConfirmVC() {
        confirmVC.modalPresentationStyle = .fullScreen
        present(confirmVC,animated: false)
    }
    
}

enum PuppyTypeEnum: String {
    case bichon, welshCorgi, pomeranian
}

enum BabyPuppyTypeEnum: String {
    case babyBichon, babyWelshCorgi, babyPomeranian
}

import SwiftUI
#Preview{
    PuppySelectionViewController()
}
