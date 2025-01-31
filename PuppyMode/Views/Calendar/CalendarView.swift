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
import ToosieSlide

class CalendarView: UIView {
    // MARK: - view
    // 년도
    public let yearLabel = UILabel().then {
        $0.font = UIFont(name: "Roboto-Medium", size: 20)
    }
    
    // 달력 버튼
    public let changeButton = UIButton().then {
        $0.setImage(.iconChangeCalendar, for: .normal)

        // 내부 이미지 크기 조절
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
    }
    
    // 월
    public let monthLabel = UILabel().then {
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 35)
    }
    
    // 날짜 타이틀 스택뷰
    private let dateTitleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    public let afterYearLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.isHidden = true
    }
    
    public let afterMonthLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        $0.isHidden = true
    }
    
    public let afterChangeButton = UIButton().then {
        $0.setImage(.iconChangeCalenderAfter, for: .normal)
        $0.isHidden = true
    }
    
    // 캘린더
    public let calendar = FSCalendar().then {
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
        
        // 오늘 날짜 표시
        $0.appearance.todayColor = .none
        $0.appearance.titleTodayColor = .black
        
        // 이벤트 색상
        $0.appearance.eventDefaultColor = .main
        $0.appearance.eventSelectionColor = .main
    }
    
    // 캐러셀 배경
    public let carouselBackground = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
    // 캐러셀
    public let carouselSlide = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCarouselLayout().then {
        $0.itemSize = CGSize(width: 218, height: 278)
        $0.minimumLineSpacing = 10
        $0.nonFocusedItemsAlphaValue = 1
    }).then {
        $0.isHidden = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    
    // 블러 배경
    public let blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .light)).then {
        $0.isHidden = true
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
    public func updateMonthLabel(for date: Date) {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        yearLabel.text = yearFormatter.string(from: date)
        afterYearLabel.text = yearFormatter.string(from: date)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M월"
        monthLabel.text = monthFormatter.string(from: date)
        afterMonthLabel.text = monthFormatter.string(from: date)
    }
    
    public func updateCalendar(for year: Int, month: Int) {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let newDate = calendar.date(from: dateComponents) {
            self.calendar.setCurrentPage(newDate, animated: true)
            updateMonthLabel(for: newDate)
        }
    }
    
    private func setStackView() {
        [ afterYearLabel, afterMonthLabel ].forEach { dateTitleStackView.addArrangedSubview($0) }
    }
    
    private func setView() {
        setStackView()
        
        [
            dateTitleStackView, afterChangeButton,
            yearLabel,
            changeButton,
            monthLabel,
            calendar,
            carouselBackground, carouselSlide,
            blurBackgroundView
        ].forEach {
            addSubview($0)
        }
        
        dateTitleStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(90)
        }
        
        afterChangeButton.snp.makeConstraints {
            $0.centerY.equalTo(dateTitleStackView)
            $0.left.equalTo(dateTitleStackView.snp.right).offset(-5)
        }
        
        yearLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(27)
            $0.bottom.equalTo(monthLabel.snp.top)
        }
        
        changeButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.left.equalTo(yearLabel.snp.right).offset(9)
            $0.bottom.equalTo(yearLabel.snp.bottom)
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
        
        carouselBackground.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.centerY.equalTo(carouselSlide)
            $0.height.equalTo(120)
        }
        
        carouselSlide.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(274)
        }
        
        blurBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - extension
extension CalendarView: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateMonthLabel(for: calendar.currentPage)
    }
}
