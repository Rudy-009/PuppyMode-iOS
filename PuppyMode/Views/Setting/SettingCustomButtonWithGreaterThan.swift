//
//  SettingCustomButton.swift
//  PuppyMode
//
//  Created by 이승준 on 1/11/25.
//

import UIKit

class SettingCustomButtonWithGreaterThan: UIButton {
    
    private lazy var title = UILabel().then { label in
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
    }
    
    private lazy var biggerImage = UIImageView().then { image in
        image.image = UIImage(named: "Bigger")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        self.addSubview(title)
        self.addSubview(biggerImage)
        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(36)
        }
        
        biggerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-36)
            make.height.equalTo(8)
            make.width.equalTo(4)
        }
    }
    
    public func setTitle(for title: String) {
        self.title.text = title
    }
    
}
