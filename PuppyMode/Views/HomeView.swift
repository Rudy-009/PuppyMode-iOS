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
    
    lazy public var editDogNameButton = UIButton().then { button in
        button.setImage(UIImage(named: "EditButtonIcon"), for: .normal)
    }
    
    //MARK: Top Buttons
    lazy private var topButtonStack = UIView()
    
    let topRectangleHeight = 53
    let topRectangleWidth = 53
    let topButtonsCornerRadius: CGFloat = 10
    let topButtonSpacing = 11
    let topButtonSuperViewSpacing = 22
    
    lazy public var decorationButton = UIButton().then { button in
        button.setImage(UIImage(named: "DecorationButtonImage"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy public var rompingButton = UIButton().then { button in
        button.setImage(UIImage(named: "RompingButtonImage"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy public var collectionButton = UIButton().then { button in
        button.setImage(UIImage(named: "CollectionButtonImage"), for: .normal)
        button.layer.cornerRadius = topButtonsCornerRadius
    }
    
    lazy private var decorationLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "꾸미기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy private var rompingLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "놀아주기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    lazy private var collectionLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "컬렉션", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    //MARK: Puppy Image & Name
    
    lazy public var puppyImageButton = UIButton().then { button in
        button.setImage(UIImage(named: "HomeCharacterDefaultImage"), for: .normal)
    }
    
    lazy private var puppyNameLabel = UILabel().then { label in
        label.font = UIFont(name: "OTSBAggroM", size: 25)
        label.text = "브로콜리"
    }
    
    //MARK: Bottom Dog Info
    lazy private var bottomStack = UIView().then { view in
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
    }
    
    lazy public var dogInfoLabel = UILabel().then { label in
        label.text = "Level 1 아기사자 포메라니안"
        label.font = UIFont(name: "OTSBAggroM", size: 14)
        label.textColor = UIColor(red: 0.624, green: 0.584, blue: 0.584, alpha: 1)
    }
    
    lazy public var progressLabel = UILabel().then { label in
        label.text = "55%"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = UIColor(red: 0.624, green: 0.584, blue: 0.584, alpha: 1)
    }
    
    lazy public var progressBar = UIProgressView().then{pro in
        pro.setProgress(0.55, animated: false)
        pro.tintColor = .progressBar
        pro.largeContentImage = UIImage(named: "ProgressBarBackground")
        pro.clipsToBounds = true
        pro.layer.cornerRadius = 10.5
    }
    
    //MARK: Drinking Capacity Button
    lazy public var drinkingCapacityButton = HomeCustomButtonView()
    lazy public var addDrinkingHistoryButton = HomeCustomButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        self.addTopButtonComponents()
        self.addPuppyImageAndName()
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
        topButtonStack.addSubview(decorationButton)
        topButtonStack.addSubview(collectionButton)
        
        topButtonStack.addSubview(decorationLabel)
        topButtonStack.addSubview(rompingLabel)  
        topButtonStack.addSubview(collectionLabel)
        
        topButtonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(topButtonSuperViewSpacing)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(48)
            make.height.equalTo(topRectangleHeight)
        }
        
        decorationButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(rompingButton.snp.leading).offset(-topButtonSpacing)
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        rompingButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(collectionButton.snp.leading).offset(-topButtonSpacing)
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        collectionButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(topRectangleHeight)
            make.width.equalTo(topRectangleWidth)
        }
        
        rompingLabel.snp.makeConstraints { make in
            make.top.equalTo(rompingButton.snp.bottom).offset(-2)
            make.centerX.equalTo(rompingButton.snp.centerX)
        }
        
        decorationLabel.snp.makeConstraints { make in
            make.top.equalTo(decorationButton.snp.bottom).offset(-2)
            make.centerX.equalTo(decorationButton.snp.centerX)
        }
        
        collectionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionButton.snp.bottom).offset(-2)
            make.centerX.equalTo(collectionButton.snp.centerX)
        }
        
    }

    private func addPuppyImageAndName() {
        
        self.addSubview(puppyImageButton)
        
        puppyImageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(superViewSpacing)
            make.height.equalTo(247)
            make.top.equalTo(topButtonStack.snp.bottom).offset(41)
        }
        
        self.addSubview(puppyNameLabel)
        
        puppyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(puppyImageButton.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addBottomComponents() {
        self.addSubview(bottomStack)
        
        bottomStack.addSubview(dogInfoLabel)
        bottomStack.addSubview(progressLabel)
        bottomStack.addSubview(progressBar)
        
        bottomStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(puppyNameLabel.snp.bottom).offset(19)
            make.height.equalTo(274)
            make.width.equalTo(361)
        }
        
        dogInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(31)
        }
        
        progressLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-37)
            make.top.equalToSuperview().offset(31)
        }
        
        progressBar.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(21)
        }
        
        bottomStack.addSubview(drinkingCapacityButton)
        
        drinkingCapacityButton.setTitleLabel(to: "주량 확인")
        drinkingCapacityButton.setSubTitleLabel(to: "술 마실 거에요")
        
        drinkingCapacityButton.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(107)
            make.top.equalTo(progressBar.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(30)
        }
        
        addDrinkingHistoryButton.setTitleLabel(to: "음주 기록")
        addDrinkingHistoryButton.setSubTitleLabel(to: "술 마셨어요")
        
        bottomStack.addSubview(addDrinkingHistoryButton)
        
        addDrinkingHistoryButton.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(107)
            make.top.equalTo(progressBar.snp.bottom).offset(35)
            make.trailing.equalToSuperview().offset(-30)
        }
                
    }
}

import SwiftUI
#Preview {
    HomeViewController()
}
