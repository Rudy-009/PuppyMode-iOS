//
//  SocialLoginButton.swift
//  PuppyMode
//
//  Created by 이승준 on 1/10/25.
//

import UIKit

class SocialLoginButton: UIButton {
    
    private var outterFrame = UIView().then { frame in
        frame.layer.cornerRadius = 6
    }
    
    private var nameLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        label.frame = CGRect(x: 0, y: 0, width: 272, height: 23)
        label.textAlignment = .center
    }
    
    private var logoImageView = UIImageView().then { image in
        image.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(outterFrame)
        self.addSubview(nameLabel)
        self.addSubview(logoImageView)
        
        outterFrame.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(361)
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(272)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(nameLabel.snp.leading)
            make.width.height.equalTo(17)
        }
    }
    
    func configure(name: String, logo: UIImage, backgroundColor: UIColor) {
        self.nameLabel.text = name
        self.logoImageView.image = logo
        self.outterFrame.backgroundColor = backgroundColor
    }
    
    func addFrame() {
        outterFrame.layer.cornerRadius = 6
        outterFrame.layer.borderWidth = 1
        outterFrame.layer.borderColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1).cgColor
    }

}

import SwiftUI
#Preview {
    LoginViewController()
}
