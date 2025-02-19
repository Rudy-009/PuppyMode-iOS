//
//  HomeCustomButtonView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/9/25.
//

import UIKit

class HomeCustomButtonView: UIButton {
    
    lazy private var backgroundImage = UIImageView().then {
        $0.image = .bottomButton
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var labelFrame = UIView()
    
    lazy private var buttonTitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
    }
    
    lazy private var buttonSubtitleLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 15)
        label.alpha = 0.78
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    private func addComponents() {
        self.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImage.addSubview(labelFrame)
        
        labelFrame.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-3)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(backgroundImage.snp.height).multipliedBy(0.5)
        }
        
        labelFrame.addSubview(buttonTitleLabel)
        labelFrame.addSubview(buttonSubtitleLabel)
        
        buttonTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        buttonSubtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func setTitleLabel(to title: String) {
        buttonTitleLabel.text = title
    }
    
    public func setSubTitleLabel(to title: String) {
        buttonSubtitleLabel.text = title
    }
    
    public func setBackgroundColor(to color: UIColor) {
        backgroundImage.backgroundColor = color
    }
    
    func getTitleLabel() -> String? {
        return buttonTitleLabel.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
#Preview {
    HomeViewController()
}
