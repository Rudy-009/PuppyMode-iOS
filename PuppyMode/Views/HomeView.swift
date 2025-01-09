//
//  HomeView.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import SnapKit
import Then

class HomeView: UIView {
    
    let superViewSpacing: CGFloat = 16
    
    //MARK: Top Buttons
    lazy private var topButtonStack = UIView()
    
    let topRectangleHeight = 53
    let topRectangleWidth = 53
    let topButtonsCornerRadius: CGFloat = 10
    let topButtonSpacing = 11
    let topButtonSuperViewSpacing = 22
    
    lazy public var rompingButton = UIButton().then { button in
        button.setImage(UIImage(named: "DecorateIcon"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy public var decorateButton = UIButton().then { button in
        button.setImage(UIImage(named: "DecorateIcon"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy public var collectionButton = UIButton().then { button in
        button.setImage(UIImage(named: "DecorateIcon"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy private var rompingLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "놀아주기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy private var decorateLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "꾸미기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy private var collectionLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "컬렉션", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy private var characterImageButton = UIButton().then { button in
        button.setImage(UIImage(named: "HomeCharacterDefaultImage"), for: .normal)
    }
    
    //MARK: Bottom Stack
    lazy private var bottomStack = UIView().then { view in
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
    }
    
    //MARK: Character Info Stack
    
    
    //MARK: Two Buttons
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        self.addTopButtonComponents()
        self.addCharacterComponents()
        self.addBottomComponents()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Add Compoments
extension HomeView {
    
    private func addTopButtonComponents() {
        self.addSubview(topButtonStack)
        
        topButtonStack.addSubview(rompingButton)
        topButtonStack.addSubview(decorateButton)
        topButtonStack.addSubview(collectionButton)
        
        topButtonStack.addSubview(decorateLabel)
        topButtonStack.addSubview(rompingLabel)
        topButtonStack.addSubview(collectionLabel)
        
        topButtonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(topButtonSuperViewSpacing)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(63)
            make.height.equalTo(topRectangleHeight)
        }
        
        rompingButton.snp.makeConstraints { make in
            make.trailing.equalTo(decorateButton.snp.leading).offset(-topButtonSpacing)
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        decorateButton.snp.makeConstraints { make in
            make.trailing.equalTo(collectionButton.snp.leading).offset(-topButtonSpacing)
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        collectionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        rompingLabel.snp.makeConstraints { make in
            make.top.equalTo(rompingButton.snp.bottom)
            make.centerX.equalTo(rompingButton.snp.centerX)
        }
        
        decorateLabel.snp.makeConstraints { make in
            make.top.equalTo(decorateButton.snp.bottom)
            make.centerX.equalTo(decorateButton.snp.centerX)
        }
        
        collectionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionButton.snp.bottom)
            make.centerX.equalTo(collectionButton.snp.centerX)
        }
        
    }

    private func addCharacterComponents() {
        
        self.addSubview(characterImageButton)
        
        characterImageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(superViewSpacing)
            make.height.equalTo(247)
            make.top.equalTo(topButtonStack.snp.bottom).offset(41)
        }
    }
    
    private func addBottomComponents() {
        self.addSubview(bottomStack)
        
        bottomStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(439)
            make.height.equalTo(254)
            make.width.equalTo(361)
        }
    }
}

import SwiftUI
#Preview{
    HomeViewController()
}
