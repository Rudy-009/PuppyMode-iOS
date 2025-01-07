//
//  CalendarView.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import FSCalendar
import Then
import SnapKit

class CalendarView: UIView {
    // MARK: - view
    // 년도
    
    // 달력 버튼
    
    // 월
    
    // 캘린더
    private let calendar = FSCalendar().then {
        // 배경
        $0.backgroundColor = .clear
        
        // 헤더
        $0.headerHeight = 0
        $0.appearance.headerMinimumDissolvedAlpha = 0
        
        $0.weekdayHeight = 70
        
        // 폰트
        $0.appearance.weekdayFont = UIFont(name: "NotoSansKR-Medium", size: 15)
        $0.appearance.weekdayTextColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        $0.appearance.titleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        
        // 현재 달만 표시
        $0.placeholderType = .none

    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        [
            calendar
        ].forEach {
            addSubview($0)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(210)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-150)
        }
    }

}
