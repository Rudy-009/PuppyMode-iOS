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
    
    //MARK: Notification
    private lazy var alarmSettingView = AlarmSettingView()
    
    //MARK: Policy
    public lazy var termsOfServiceAndPrivacyPolicyButton = ArrowSettingButton()
    
    //MARK: AppVersion
    private lazy var appVersionView = AppVersionView()
        
    //MARK: Revoke
    public lazy var revokeButton = ArrowSettingButton()
    
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
        self.addSubview(termsOfServiceAndPrivacyPolicyButton)
        self.addSubview(appVersionView)
        self.addSubview(revokeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        alarmSettingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        termsOfServiceAndPrivacyPolicyButton.setTitle(for: "약관 및 개인정보 처리 동의")
        
        termsOfServiceAndPrivacyPolicyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(alarmSettingView.snp.bottom).offset(7)
        }
        
        appVersionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(termsOfServiceAndPrivacyPolicyButton.snp.bottom).offset(7)
        }
        
        revokeButton.setTitle(for: "탈퇴하기")
        
        revokeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(appVersionView.snp.bottom).offset(7)
        }
        
    }
}

#Preview{
    SettingViewController()
}
