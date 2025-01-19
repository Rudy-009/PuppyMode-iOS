//
//  SettingView.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class SettingView: UIView {
    
    private lazy var titleLabel = UILabel().then { label in
        label.text = "설정"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
    }
    
    //Notification
    private lazy var alarmSettingView = AlarmSettingView()
    
    //Terms of Service
    public lazy var termsOfServiceButton = ArrowSettingButton()
    
    //Privacy Policy
    public lazy var PrivacyPolicyButton = ArrowSettingButton()
    
    //AppVersion
    private lazy var appVersionView = AppVersionView()
    
    //Revoke
    public lazy var revokeButton = ArrowSettingButton()
    
    //Logout
    public lazy var logoutButton = ArrowSettingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(titleLabel)
        self.addSubview(alarmSettingView)
        self.addSubview(termsOfServiceButton)
        self.addSubview(PrivacyPolicyButton)
        self.addSubview(appVersionView)
        self.addSubview(revokeButton)
        self.addSubview(logoutButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        alarmSettingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        termsOfServiceButton.setTitle(for: "이용약관")
        
        termsOfServiceButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(alarmSettingView.snp.bottom).offset(7)
        }
        
        PrivacyPolicyButton.setTitle(for: "개인정보 처리 동의")
        
        PrivacyPolicyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(termsOfServiceButton.snp.bottom).offset(7)
        }
        
        appVersionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(PrivacyPolicyButton.snp.bottom).offset(7)
        }
        
        revokeButton.setTitle(for: "탈퇴하기")
        
        revokeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(appVersionView.snp.bottom).offset(7)
        }
        
        logoutButton.setTitle(for: "로그아웃")
        
        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(revokeButton.snp.bottom).offset(7)
        }
        
    }
}

#Preview{
    SettingViewController()
}
