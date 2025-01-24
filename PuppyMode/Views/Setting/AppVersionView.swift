//
//  AppVersionView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit

class AppVersionView: UIView {
    
    private lazy var appVersionTitleLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
        label.text = "앱 버전"
    }
    
    private lazy var appVersionLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.537, green: 0.537, blue: 0.537, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.text = "1.0.0"
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
        
        self.addSubview(appVersionTitleLabel)
        self.addSubview(appVersionLabel)
        
        appVersionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(36)
        }
        
        appVersionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalToSuperview().offset(-36)
        }
    }
}
