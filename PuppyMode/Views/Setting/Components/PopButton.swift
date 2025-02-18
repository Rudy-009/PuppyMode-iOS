//
//  popButton.swift
//  PuppyMode
//
//  Created by 이승준 on 2/13/25.
//

import UIKit

class PopButton: UIButton {
    
    private lazy var popImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .back
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(popImage)
        
        popImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(13)
            make.center.equalToSuperview()
        }
    }
}
