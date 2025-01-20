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
    
    lazy public var editDogNameButton = UIButton().then { button in
        button.setImage(UIImage(named: "EditButtonIcon"), for: .normal)
    }
    
    //MARK: Top Buttons
    private lazy var topButtonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
    }
    
    public lazy var decorationButton = HomeTopButton()
    
    public lazy var rompingButton = HomeTopButton()
    
    public lazy var collectionButton = HomeTopButton()
    
    //MARK: Puppy Image & Name
    
    public lazy var puppyImageButton = UIButton().then { button in
        button.setImage(UIImage(named: "HomeCharacterDefaultImage"), for: .normal)
    }
    
    private lazy var puppyNameLabel = UILabel().then { label in
        label.font = UIFont(name: "OTSBAggroM", size: 25)
        label.text = "브로콜리"
    }
    
    //MARK: Bottom Dog Info
    private lazy var bottomFrame = UIView().then { view in
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
    }
    
    public lazy var dogInfoLabel = UILabel().then { label in
        label.text = "Level 1 아기사자 포메라니안"
        label.font = UIFont(name: "OTSBAggroM", size: 14)
        label.textColor = UIColor(red: 0.624, green: 0.584, blue: 0.584, alpha: 1)
    }
    
    public lazy var progressLabel = UILabel().then { label in
        label.text = "55%"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textColor = UIColor(red: 0.624, green: 0.584, blue: 0.584, alpha: 1)
    }
    
    public lazy var progressBar = UIProgressView().then{pro in
        pro.setProgress(0.55, animated: false)
        pro.tintColor = .main
        pro.largeContentImage = UIImage(named: "ProgressBarBackground")
        pro.clipsToBounds = true
        pro.layer.cornerRadius = 10.5
    }
    
    //MARK: Drinking Capacity Button
    private lazy var bottomButtonFrame = UIView().then {_ in 
    }
    
    public lazy var drinkingCapacityButton = HomeBottomButton()
    public lazy var addDrinkingHistoryButton = HomeBottomButton()
    
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
        
        topButtonStack.addArrangedSubview(decorationButton)
        topButtonStack.addArrangedSubview(rompingButton)
        topButtonStack.addArrangedSubview(collectionButton)
        
        topButtonStack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(52)
            $0.trailing.equalToSuperview().offset(-22)
        }
        
        decorationButton.configure(image: .decorationButton, title: "꾸미기")
        rompingButton.configure(image: .rompingButton, title: "놀아주기")
        collectionButton.configure(image: .collectionButton, title: "컬렉션")
    }

    private func addPuppyImageAndName() {
        
        self.addSubview(puppyImageButton)
        
        puppyImageButton.snp.makeConstraints { make in
            make.top.equalTo(topButtonStack.snp.bottom).offset(41)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(247)
        }
        
        self.addSubview(puppyNameLabel)
        
        puppyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(puppyImageButton.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addBottomComponents() {
        self.addSubview(bottomFrame)
        
        bottomFrame.addSubview(dogInfoLabel)
        bottomFrame.addSubview(progressLabel)
        bottomFrame.addSubview(progressBar)
        bottomFrame.addSubview(bottomButtonFrame)
        
        bottomFrame.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(puppyNameLabel.snp.bottom).offset(19)
            make.height.equalTo(274)
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
            make.height.equalTo(21)
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        bottomButtonFrame.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(progressBar.snp.bottom).offset(20)
        }
        
        bottomButtonFrame.addSubview(drinkingCapacityButton)
        bottomButtonFrame.addSubview(addDrinkingHistoryButton)
        
        drinkingCapacityButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(115)
        }
        
        addDrinkingHistoryButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(115)
        }
        
        drinkingCapacityButton.setTitleLabel(to: "주량 확인")
        drinkingCapacityButton.setSubTitleLabel(to: "술 마실 거에요")
        
        addDrinkingHistoryButton.setTitleLabel(to: "음주 기록")
        addDrinkingHistoryButton.setSubTitleLabel(to: "술 마셨어요")
    }
}

import SwiftUI
#Preview {
    HomeViewController()
}
