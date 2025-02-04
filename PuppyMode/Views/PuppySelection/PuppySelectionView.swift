//
//  PuppySelectionView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/26/25.
//

import UIKit

class PuppySelectionView: UIView {
    
    private lazy var mainTitleLabel = UILabel().then {
        $0.text = "같이 성장해나갈\n강아지를 선택해주세요"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 30)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var buttonsStackFrame = UIView()
    public lazy var cardButton01 = PuppyCardButtonView()
    public lazy var cardButton02 = PuppyCardButtonView()
    public lazy var cardButton03 = PuppyCardButtonView()
    public lazy var cardButton04 = PuppyCardButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainTitleLabel)
        self.addSubview(buttonsStackFrame)
        
        buttonsStackFrame.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.55)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(27)
            make.bottom.equalTo(buttonsStackFrame.snp.top).offset(-40)
        }
        
        buttonsStackFrame.addSubview(cardButton01)
        buttonsStackFrame.addSubview(cardButton02)
        buttonsStackFrame.addSubview(cardButton03)
        buttonsStackFrame.addSubview(cardButton04)
        
        cardButton01.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.428)
            make.height.equalToSuperview().multipliedBy(0.444)
        }
        
        cardButton02.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.428)
            make.height.equalToSuperview().multipliedBy(0.444)
        }
        
        cardButton03.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.428)
            make.height.equalToSuperview().multipliedBy(0.444)
        }
        
        cardButton04.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.428)
            make.height.equalToSuperview().multipliedBy(0.444)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI
#Preview{
    PuppySelectionViewController()
}
