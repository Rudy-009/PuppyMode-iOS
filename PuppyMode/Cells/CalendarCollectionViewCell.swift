//
//  CalendarCollectionViewCell.swift
//  PuppyMode
//
//  Created by 김미주 on 30/01/2025.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    
    // MARK: - layout
    public let testLabel = UILabel()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .main
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        [
            testLabel
        ].forEach {
            addSubview($0)
        }
        
        testLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
