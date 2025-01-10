//
//  LoginView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/10/25.
//

import UIKit

class LoginView: UIView {
    
    lazy private var slogunLabel = UILabel().then { label in
        label.text = "어차피 못지킬 약속,\n강아지 모드가 도와드립니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "NotoSansKR-Bold", size: 28)
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
    }
    
    lazy private var subLabel = UILabel().then { label in
        label.text = "올바른 음주 습관을 가질 수 있도록 도와드릴게요"
        label.numberOfLines = 0
        label.font = UIFont(name: "NotoSansKR-Medium", size: 17)
        label.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.97
        // Line height: 24 pt
        // (identical to box height)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "올바른 음주 습관을 가질 수 있도록 도와드릴게요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

    }
    
    lazy private var characterImage = UIImageView().then { image in
        image.image = UIImage(named: "HomeCharacterDefaultImage")
    }
    
    lazy public var appleLoginButton = SocialLoginButton()
    
    lazy public var kakaoLoginButton = SocialLoginButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(slogunLabel)
        self.addSubview(subLabel)
        self.addSubview(characterImage)
        self.addSubview(appleLoginButton)
        self.addSubview(kakaoLoginButton)
        
        slogunLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(81)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(slogunLabel.snp.bottom).offset(17)
        }
        
        characterImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(250)
            make.top.equalTo(subLabel.snp.bottom).offset(30)
        }
                
        kakaoLoginButton.configure(name: "카카오로 로그인", logo: UIImage(named: "KakaoLogin")!, backgroundColor: .kakaoLogin)
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-40)
        }
        
        appleLoginButton.configure(name: "Apple로 로그인", logo: UIImage(named: "AppleLogin")!, backgroundColor: .white)
        appleLoginButton.addFrame()
        
        appleLoginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-130)
        }

    }
}

import SwiftUI
#Preview {
    LoginViewController()
}
