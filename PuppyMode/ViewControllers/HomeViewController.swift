//
//  HomeViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = homeView
        self.defineButtonActions()
    }

}

//MARK: Add Button Actions
extension HomeViewController {
    private func defineButtonActions() {
        self.homeView.decorationButton.addTarget(self, action: #selector(decorationButtonPressed), for: .touchUpInside)
        self.homeView.rompingButton.addTarget(self, action: #selector(rompingButtonPressed), for: .touchUpInside)
        self.homeView.collectionButton.addTarget(self, action: #selector(collectionPressed), for: .touchUpInside)
        self.homeView.puppyImageButton.addTarget(self, action: #selector(puppyImagePressed), for: .touchUpInside)
        self.homeView.drinkingCapacityButton.addTarget(self, action: #selector(drinkingCapacityButtonPressed), for: .touchUpInside)
        self.homeView.addDrinkingHistoryButton.addTarget(self, action: #selector(addDrinkingHistoryButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func decorationButtonPressed() {
        print("Decoration Button Pressed")
    }
    
    @objc
    private func rompingButtonPressed() {
        print("Romping Button Pressed")
    }
    
    @objc
    private func collectionPressed() {
        print("Collection Button Pressed")
    }
    
    @objc
    private func puppyImagePressed() {
        print("Puppy Image Button Pressed")
    }
    
    @objc
    private func drinkingCapacityButtonPressed() {
        print("Drinking Capacity Button Pressed")
    }
    
    @objc
    private func addDrinkingHistoryButtonPressed() {
        print("Add Drinking History Button Pressed")
    }
    
}

import SwiftUI
#Preview {
    HomeViewController()
}
