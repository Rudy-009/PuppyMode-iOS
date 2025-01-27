//
//  PuppySelectionConfirmViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import UIKit
import Alamofire

class PuppySelectionConfirmViewController: UIViewController {
    
    private let puppySelectionConfirmView = PuppySelectionConfirmView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        self.view = puppySelectionConfirmView
    }
    
    private func connectButtonActions() {
        puppySelectionConfirmView.startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func startButtonPressed() {
        
    }
    
    public func configure(puppy: BabyPuppyTypeEnum) {
        puppySelectionConfirmView.configure(puppy: puppy)
    }
}
