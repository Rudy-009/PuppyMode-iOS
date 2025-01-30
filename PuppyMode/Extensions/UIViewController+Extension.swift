//
//  UIViewController+Extension.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//


import UIKit

extension UIViewController {
    
    func setupNavigationBar(title: String, action: Selector) {
        self.navigationItem.hidesBackButton = true
        
        
        let backImage = UIImage(named: "backButtonImage")
        let resizedBackImage = UIGraphicsImageRenderer(size: CGSize(width: 9, height: 16)).image { _ in
            backImage?.draw(in: CGRect(origin: .zero, size: CGSize(width: 9, height: 16)))
        }
        
        let customBackButton = UIBarButtonItem(image: resizedBackImage, style: .plain, target: self, action: action)

        customBackButton.tintColor = UIColor.black
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)

        
        self.navigationItem.leftBarButtonItem = customBackButton
        self.navigationItem.title = title
        
        let font = UIFont(name: "NotoSansKR-Regular", size: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()  // 스크롤시 네비게이션 바에 그림자가 자동으로 생기기 때문에 그림자도 제거해야함
        

    }
    
    @objc func customBackButtonTapped() {
        // 네비게이션 스택인지, 모달인지 확인
        if let navigationController = self.navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
