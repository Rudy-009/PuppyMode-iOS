//
//  LogoutCheckView.swift
//  PuppyMode
//
//  Created by 이승준 on 2/6/25.
//

import UIKit
import SnapKit
import Then

class LogoutCheckView: UIView {
    
    public lazy var mainFrame = UIView().then {
        $0.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
        $0.layer.cornerRadius = 10
    }
    
    public lazy var mainTitleLabel = UILabel().then {
        $0.text = "정말 로그아웃을 하시겠습니까?"
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
    }
    
    private lazy var buttonFrame = UIView()
    
    public lazy var confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        $0.setTitleColor(UIColor(red: 0.297, green: 0.297, blue: 0.297, alpha: 1), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .main
    }
    
    public lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        $0.setTitleColor(UIColor(red: 0.297, green: 0.297, blue: 0.297, alpha: 1), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(mainFrame)
        
        mainFrame.addSubview(mainTitleLabel)
        mainFrame.addSubview(buttonFrame)
        
        buttonFrame.addSubview(confirmButton)
        buttonFrame.addSubview(cancelButton)
        
        mainFrame.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(180)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(46)
        }
        
        buttonFrame.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(33)
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(33)
            make.height.equalTo(43)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.46)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.46)
        }
    }
    
}

import SwiftUI
#Preview {
    LogoutCheckViewController()
}
