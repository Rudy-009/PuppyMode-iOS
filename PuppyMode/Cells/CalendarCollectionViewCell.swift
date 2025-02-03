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
    private let backView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.707, green: 0.918, blue: 0.862, alpha: 1)
        $0.layer.cornerRadius = 20
        
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public let dateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.34, green: 0.34, blue: 0.34, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 16)
    }
    
    public let dayLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
    }
    
    private let recordButton = UIButton()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        [
            backView,
            dateLabel
        ].forEach {
            addSubview($0)
        }
        
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
    }
}
