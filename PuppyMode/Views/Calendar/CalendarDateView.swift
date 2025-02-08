//
//  CalendarDateView.swift
//  PuppyMode
//
//  Created by 김미주 on 09/02/2025.
//

import UIKit

class CalendarDateView: UIView {

    // MARK: - layout
    // 배경
    private let backView = UIView().then {
        $0.layer.cornerRadius = 30
        $0.layer.borderWidth = 1.49
        $0.layer.borderColor = UIColor(red: 0.877, green: 0.877, blue: 0.877, alpha: 1).cgColor
    }
    
    // 날짜
    
    // 날
    
    // 음주 기록
    
    // 술 약속
    
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
            backView
        ].forEach {
            addSubview($0)
        }
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
