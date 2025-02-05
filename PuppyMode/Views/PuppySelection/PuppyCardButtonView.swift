//
//  PuppyCardButton.swift
//  PuppyMode
//
//  Created by 이승준 on 2/3/25.
//

import UIKit

class PuppyCardButtonView: UIButton {
    
    private lazy var mainFrame = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.777, green: 0.777, blue: 0.777, alpha: 1).cgColor
    }
    
    private lazy var puppyImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .defaultPuppy
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainFrame)
        mainFrame.addSubview(puppyImage)
        
        mainFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        puppyImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
