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
    
    public lazy var cardButton01 = UIButton().then {
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .caution
    }
    
    public lazy var cardButton02 = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.backgroundColor = .kakaoLogin
    }
    
    public lazy var cardButton03 = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.backgroundColor = .main
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainTitleLabel)
        self.addSubview(cardButton01)
        self.addSubview(cardButton02)
        self.addSubview(cardButton03)
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(27)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(183)
        }
        
        cardButton01.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(300)
            make.width.equalTo(100)
        }
        
        cardButton02.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(cardButton01.snp.trailing).offset(20)
            make.height.equalTo(300)
            make.width.equalTo(100)
        }
        
        cardButton03.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(cardButton02.snp.trailing).offset(20)
            make.height.equalTo(300)
            make.width.equalTo(100)
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
