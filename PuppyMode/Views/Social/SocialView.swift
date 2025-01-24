//
//  SocialView.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class SocialView: UIView {
    
    private lazy var titleLabel = UILabel().then { label in
        label.text = "랭킹"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    public lazy var segmentView = UISegmentedControl(items: ["전체 랭킹", "친구 랭킹"]).then { seg in
        let customFont = UIFont(name: "NotoSansKR-Medium", size: 16)!
        seg.selectedSegmentIndex = 0
        seg.setTitleTextAttributes([
            NSAttributedString.Key.font: customFont
        ], for: .normal)
    }
    
    public lazy var label01 = UILabel().then { label in
        label.text = "전체 랭킹"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 40)
    }
    
    public lazy var label02 = UILabel().then { label in
        label.text = "친구 랭킹"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 40)
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
        self.addSubview(titleLabel)
        self.addSubview(segmentView)
        self.addSubview(label01)
        self.addSubview(label02)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        segmentView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(42)
        }
        
        label01.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label02.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label02.isHidden = true
    }
}

#Preview{
    SocialViewController()
}

