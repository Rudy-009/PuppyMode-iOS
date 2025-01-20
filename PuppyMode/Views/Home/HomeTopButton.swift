//
//  HomeTopButton.swift
//  PuppyMode
//
//  Created by 이승준 on 1/20/25.
//

import UIKit
import SnapKit
import Then

class HomeTopButton: UIButton {
    
    let topButtonsCornerRadius: CGFloat = 10
    
    private lazy var iconImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = topButtonsCornerRadius
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.snp.makeConstraints {
            $0.height.equalTo(72)
            $0.width.equalTo(52)
        }
        
        self.addSubview(iconImage)
        self.addSubview(nameLabel)
        
        iconImage.snp.makeConstraints {
            $0.height.width.equalTo(52)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    public func configure(image: UIImage, title: String) {
        iconImage.image = image
        nameLabel.text = title
    }
}
