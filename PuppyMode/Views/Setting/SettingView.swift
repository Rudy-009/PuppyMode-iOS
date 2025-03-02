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
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    //Notification
    public lazy var alarmSettingView = AlarmSettingView()
    
    //Terms of Service
    public lazy var termsOfServiceButton = ArrowSettingButton()
    
    //Privacy Policy
    public lazy var PrivacyPolicyButton = ArrowSettingButton()
    
    //AppVersion
    private lazy var appVersionView = AppVersionView()
    
    //Revoke
    public lazy var revokeButton = ArrowSettingButton()
    
    //Logout
    public lazy var logoutButton = UIButton().then {
        $0.setImage(.logout, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
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
        self.addSubview(stackView)
        self.addSubview(logoutButton)
        stackView.addArrangedSubview(alarmSettingView)
        stackView.addArrangedSubview(termsOfServiceButton)
        stackView.addArrangedSubview(PrivacyPolicyButton)
        stackView.addArrangedSubview(appVersionView)
        stackView.addArrangedSubview(revokeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(75)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(6)
            make.height.width.equalTo(70)
        }
        
        logoutButton.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        termsOfServiceButton.setTitle(for: "이용약관")
        
        PrivacyPolicyButton.setTitle(for: "개인정보 처리 동의")
        
        revokeButton.setTitle(for: "탈퇴하기")
        
    }
}

#Preview{
    SettingViewController()
}
