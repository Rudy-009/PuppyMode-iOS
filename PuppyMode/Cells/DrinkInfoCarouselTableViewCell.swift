//
//  DrinkInfoCarouselTableViewCell.swift
//  PuppyMode
//
//  Created by 박준석 on 2/12/25.
//

import UIKit

class DrinkInfoCarouselCollectionViewCell: UICollectionViewCell {

    static let identifier = "DrinkInfoCarouselCollectionViewCell"
        
        private let imageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.backgroundColor = UIColor(hex: "#FFFFFF")
            
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.25
            contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
            contentView.layer.shadowRadius = 4
            
            contentView.layer.cornerRadius = 10
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor(hex: "#A8A8A8").cgColor
            
            contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(withImageName imageName: String) {
            imageView.image = UIImage(named: imageName)
        }

}
