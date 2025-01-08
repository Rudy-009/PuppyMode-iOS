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
    private let yearLabel = UILabel().then {
        $0.text = "0000"
        $0.font = UIFont(name: "Roboto-Medium", size: 20)
    }
    
    // 달력 버튼
    
    // 월
    private let monthLabel = UILabel().then {
        $0.text = "Month"
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 35)
    }
    
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

        // 한글로 변경
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        calendar.delegate = self
        setView()
        updateMonthLabel(for: calendar.currentPage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func updateMonthLabel(for date: Date) {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        yearLabel.text = yearFormatter.string(from: date)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M월"
        monthLabel.text = monthFormatter.string(from: date)
    }
    
    private func setView() {
        [
            yearLabel,
            monthLabel,
            calendar
        ].forEach {
            addSubview($0)
        }
        
        yearLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(27)
            $0.bottom.equalTo(monthLabel.snp.top)
        }
        
        monthLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(23)
            $0.bottom.equalTo(calendar.snp.top).offset(-30)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(210)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-150)
        }
    }

}

// MARK: - extension
extension CalendarView: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateMonthLabel(for: calendar.currentPage)
    }
}
