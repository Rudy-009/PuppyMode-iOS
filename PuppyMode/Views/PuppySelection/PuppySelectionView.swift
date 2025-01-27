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
    
    private lazy var pomeranianButton = UIButton().then {
        $0.setTitle("포메라리안", for: .selected)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .caution
    }
    
    private lazy var welshCorgiButton = UIButton().then {
        $0.setTitle("웰시코기", for: .selected)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.backgroundColor = .kakaoLogin
    }
    
    private lazy var bichonButton = UIButton().then {
        $0.setTitle("비숑", for: .selected)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.backgroundColor = .main
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainTitleLabel)
        self.addSubview(pomeranianButton)
        self.addSubview(welshCorgiButton)
        self.addSubview(bichonButton)
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(27)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(183)
        }
        
        pomeranianButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
        }
        
        welshCorgiButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(pomeranianButton.snp.bottom).offset(30)
        }
        
        bichonButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(welshCorgiButton.snp.bottom).offset(30)
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
