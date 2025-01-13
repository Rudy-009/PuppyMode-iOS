//
//  MonthCollectionViewCell.swift
//  PuppyMode
//
//  Created by 김미주 on 14/01/2025.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    static let identifier = "MonthCollectionViewCell"
    
    // MARK: - layout
    
    // 텍스트
    public let monthLabel = UILabel().then {
        $0.text = "월"
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 19)
        $0.textColor = UIColor(red: 0.29, green: 0.278, blue: 0.38, alpha: 1)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        addSubview(monthLabel)
        
        monthLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
