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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    public lazy var decoItemLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.isHidden = false
    }
    
    public lazy var lockImageView = UIImageView().then { imageView in
        imageView.image = UIImage(named: "lockImage")
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = CGSize(width: 26, height: 26)
        imageView.clipsToBounds = true
        imageView.isHidden = false
    }
        
    let overlayView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10

        self.addComponents()
        addDarkOverlay()
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
        
        self.addSubview(lockImageView)
        lockImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
        }
        self.bringSubviewToFront(lockImageView)


    }
    
    private func addDarkOverlay() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        decoItemImageView.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
}
