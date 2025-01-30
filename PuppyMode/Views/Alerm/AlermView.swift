//
//  AlermView.swift
//  PuppyMode
//
//  Created by 김민지 on 1/28/25.
//

import UIKit
import Then

class AlermView: UIButton {
    
    lazy private var backgroundImage = UIImageView().then { image in
        image.image = UIImage(named: "alermBackgroundImage")
    }
    
    private lazy var coinImageView = UIImageView().then { imageView in
        imageView.image = UIImage(named: "coin")
        imageView.contentMode = .scaleAspectFit
    }
    
    public lazy var coinLabel = UILabel().then { label in
        label.text = "코인 휙득!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Bold", size: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    private func addComponents() {
        self.addSubview(backgroundImage)
        
        backgroundImage.addSubview(coinImageView)
        backgroundImage.addSubview(coinLabel)
    
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalTo(coinLabel)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setTitleLabel( to title: String) {
        coinLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
