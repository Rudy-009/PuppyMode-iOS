//
//  HomeCustomButtonView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/9/25.
//

import UIKit

class HomeCustomButtonView: UIView {
    
    lazy private var drinkingCapacityButtonBackgroundImage = UIImageView().then { image in
        image.image = UIImage(named: "BottomButtonImage")
    }
    
    lazy private var drinkingCapacityTitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy private var drinkCapacitySubtitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 15)
        label.alpha = 0.78
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    func addComponents() {
        self.addSubview(drinkingCapacityButtonBackgroundImage)
        
        drinkingCapacityButtonBackgroundImage.addSubview(drinkingCapacityTitleLabel)
        drinkingCapacityButtonBackgroundImage.addSubview(drinkCapacitySubtitleLabel)
        
        drinkingCapacityButtonBackgroundImage.snp.makeConstraints { make in
            make.width.equalTo(138)
            make.height.equalTo(107)
        }
        
        drinkingCapacityTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        
        drinkCapacitySubtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(drinkingCapacityTitleLabel.snp.bottom).offset(6)
        }
    }
    
    func setTitleLabel( to title: String) {
        drinkingCapacityTitleLabel.text = title
    }
    
    func setSubTitleLabel( to title: String) {
        drinkCapacitySubtitleLabel.text = title
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
