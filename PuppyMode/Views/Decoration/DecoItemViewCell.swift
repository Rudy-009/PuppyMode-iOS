//
//  DecorationItemViewCell.swift
//  PuppyMode
//
//  Created by 김민지 on 1/19/25.
//

import UIKit
import Then

class DecoItemViewCell: UICollectionViewCell {
    
    static let identifier = "DecoItemViewCell"
    
    public lazy var decoItemImageView = UIImageView().then { imageView in
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    public lazy var decoItemLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10

        self.addComponents()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(decoItemImageView)
        decoItemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(decoItemLabel)
        decoItemLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(3)
            make.centerX.equalToSuperview()
        }
    }
    
}
