//
//  HomeViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = homeView
        self.navigationController?.isNavigationBarHidden = true
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
        let decoVC = DecoViewController()
        decoVC.hidesBottomBarWhenPushed = true  // 탭바 숨기기 설정
        navigationController?.pushViewController(decoVC, animated: true)
    }
    
    @objc
    private func rompingButtonPressed() {
        print("Romping Button Pressed")
    }
    
    @objc
    private func collectionPressed() {
        let collectionVC = CollectionViewController()
        collectionVC.hidesBottomBarWhenPushed = true  
        navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    @objc
    private func puppyImagePressed() {
        print("Puppy Image Button Pressed")
    }
    
    // 주량 확인 페이지 이동 함수
    @objc private func drinkingCapacityButtonPressed() {
        print("Drinking Capacity Button Pressed")
        
        let drinkingInfoVC = DrinkingInfoViewController()
        drinkingInfoVC.hidesBottomBarWhenPushed = true  // 탭 바 숨기기 설정
        
        // 네비게이션 컨트롤러를 통해 화면 전환
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drinkingInfoVC, animated: true)
        } else {
            // 네비게이션 컨트롤러가 없으면 새로 생성하여 표시
            let navController = UINavigationController(rootViewController: drinkingInfoVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    @objc
    private func addDrinkingHistoryButtonPressed() {
        print("Add Drinking History Button Pressed")

        let hangoverVC = HangoverViewController()
        self.navigationController?.isNavigationBarHidden = true
        hangoverVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hangoverVC, animated: true)

        /* 음주 중 화면으로 이동 분기
        let drinkingVC = DrinkingViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drinkingVC, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: drinkingVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        */
    }
}

import SwiftUI
#Preview {
    HomeViewController()
}
