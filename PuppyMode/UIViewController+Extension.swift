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
        

    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
