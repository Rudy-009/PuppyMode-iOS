//
//  alarmSettingView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit

class AlarmSettingView: UIView {
    
    private lazy var notificationTitleLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
        label.text = "알림"
    }
    
    public lazy var toggleView = UISwitch().then { toggle in
        toggle.onTintColor = .main
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        self.addSubview(notificationTitleLabel)
        self.addSubview(toggleView)
        
        notificationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(36)
        }
        
        toggleView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalToSuperview().offset(-36)
        }
    }
    
}


