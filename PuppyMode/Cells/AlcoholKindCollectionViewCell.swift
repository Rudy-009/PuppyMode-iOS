//
//  AlcoholKindCollectionViewCell.swift
//  PuppyMode
//
//  Created by 김미주 on 23/01/2025.
//

import UIKit

class AlcoholKindCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlcoholKindCollectionViewCell"
    
    // MARK: - layout
    // 타이틀
    public let titleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 16)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
