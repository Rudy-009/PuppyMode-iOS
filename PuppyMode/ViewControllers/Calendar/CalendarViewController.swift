//
//  CalendarViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    private let calendarView = CalendarView()

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
    }
    
    // MARK: - action
    private func setAction() {
        calendarView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        calendarView.afterChangeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func changeButtonTapped() {
        calendarView.blurBackgroundView.isHidden = false
        let modalVC = CalendarModalViewController(calendarView: calendarView)
        modalVC.modalPresentationStyle = .overFullScreen
        present(modalVC, animated: true)
    }

}

// MARK: - extension
extension CalendarViewController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
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
            
            self.calendarView.carouselSlide.isHidden = false
            
            self.calendarView.calendar.transform = CGAffineTransform(translationX: 0, y: -170)
            self.calendarView.carouselSlide.transform = CGAffineTransform(translationX: 0, y: -170)
        })
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .black
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarView.updateMonthLabel(for: calendar.currentPage)
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = [ "1", "2", "3", "4", "5", "6", "7", "8" ]
        cell.testLabel.text = list[indexPath.row]
        return cell
    }
}
