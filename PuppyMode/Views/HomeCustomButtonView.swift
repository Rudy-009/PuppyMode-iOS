//
//  HomeCustomButtonView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/9/25.
//

import UIKit

class HomeCustomButtonView: UIButton {
    
    lazy private var backgroundImage = UIImageView().then { image in
        image.image = UIImage(named: "BottomButtonImage")
    }
    
    lazy private var buttonTitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    lazy private var buttonSubtitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 15)
        label.alpha = 0.78
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    func addComponents() {
        self.addSubview(backgroundImage)
        
        backgroundImage.addSubview(buttonTitleLabel)
        backgroundImage.addSubview(buttonSubtitleLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(138)
            make.height.equalTo(107)
        }
        
        buttonTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        buttonSubtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonTitleLabel.snp.bottom).offset(6)
        }
    }
    
    func setTitleLabel( to title: String) {
        buttonTitleLabel.text = title
    }
    
    func setSubTitleLabel( to title: String) {
        buttonSubtitleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
