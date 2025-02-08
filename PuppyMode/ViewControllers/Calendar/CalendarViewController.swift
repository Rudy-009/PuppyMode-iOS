//
//  CalendarViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import FSCalendar
import ToosieSlide

class CalendarViewController: UIViewController {
    private let calendarView = CalendarView()
    
    private var lastContentOffset: CGFloat = 0 // 스크롤 시작 위치 저장 변수
    
    private var selectedDate: Date? {
        didSet {
            guard let selectedDate = selectedDate else { return }
            calendarView.calendar.select(selectedDate)
            calendarView.updateMonthLabel(for: selectedDate)
        }
    }

    private var dates: [Date] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        
        setDelegate()
        setAction()
    }
    
    // MARK: - function
    private func setDelegate() {
        calendarView.calendar.delegate = self
        calendarView.carouselSlide.dataSource = self
        calendarView.carouselSlide.delegate = self
    }
    
    // MARK: - action
    private func setAction() {
        calendarView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        calendarView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        calendarView.afterChangeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.calendarView.yearLabel.isHidden = false
        self.calendarView.monthLabel.isHidden = false
        self.calendarView.changeButton.isHidden = false
        
        self.calendarView.afterYearLabel.isHidden = true
        self.calendarView.afterMonthLabel.isHidden = true
        self.calendarView.afterChangeButton.isHidden = true
        
        self.calendarView.carouselBackground.isHidden = true
        self.calendarView.carouselSlide.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.calendarView.calendar.transform = .identity
            self.calendarView.carouselBackground.transform = .identity
            self.calendarView.carouselSlide.transform = .identity
        })
    }
    
    @objc
    private func changeButtonTapped() {
        calendarView.modalBackgroundView.alpha = 0
        calendarView.modalBackgroundView.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.calendarView.modalBackgroundView.alpha = 1
        }
        
        let modalVC = CalendarModalViewController(calendarView: calendarView)
        modalVC.modalPresentationStyle = .overFullScreen
        present(modalVC, animated: true)
    }

}

// MARK: - extension
extension CalendarViewController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        dateFormatter.locale = Locale(identifier: "ko_KR")
//        let formattedDate = dateFormatter.string(from: date)
//        
//        let detailVC = CalendarDetailViewController()
//        detailVC.calendarDetailView.dateLabel.text = formattedDate
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.pushViewController(detailVC, animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.calendarView.yearLabel.isHidden = true
            self.calendarView.monthLabel.isHidden = true
            self.calendarView.changeButton.isHidden = true
            
            self.calendarView.afterYearLabel.isHidden = false
            self.calendarView.afterMonthLabel.isHidden = false
            self.calendarView.afterChangeButton.isHidden = false
            
            self.calendarView.carouselBackground.isHidden = false
            self.calendarView.carouselSlide.isHidden = false
            
            self.calendarView.calendar.transform = CGAffineTransform(translationX: 0, y: -170)
            self.calendarView.carouselBackground.transform = CGAffineTransform(translationX: 0, y: -170)
            self.calendarView.carouselSlide.transform = CGAffineTransform(translationX: 0, y: -170)
        })
        
        calendarView.carouselSlide.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .black
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.updateMonthLabel(for: calendar.currentPage)
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.max
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            cell.dateLabel.text = dateFormatter.string(from: selectedDate)
        }
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.x // 스크롤 시작할 때 위치 저장
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let selectedDate = selectedDate else { return }

        let currentOffset = scrollView.contentOffset.x

        // 스크롤 방향 판별
        let dateChange = currentOffset > lastContentOffset ? 1 : -1
        
        // 날짜 변경
        let newDate = Calendar.current.date(byAdding: .day, value: dateChange, to: selectedDate) ?? selectedDate
        self.selectedDate = newDate
        
        // 달력(FSCalendar)에 반영
        calendarView.calendar.select(newDate)
        calendarView.updateMonthLabel(for: newDate)
        
        // 캐러셀 갱신
        calendarView.carouselSlide.reloadData()
    }
}
