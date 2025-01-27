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
        puppySelectionView.cardButton03.addTarget(self, action: #selector(showConfirmVC), for: .touchUpInside)
        puppySelectionView.cardButton02.addTarget(self, action: #selector(showConfirmVC), for: .touchUpInside)
        puppySelectionView.cardButton01.addTarget(self, action: #selector(showConfirmVC), for: .touchUpInside)
    }
    
    @objc
    private func showConfirmVC() {
        confirmVC.modalPresentationStyle = .fullScreen
        
        
        confirmVC.configure(puppy: .babyBichon)
        
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
