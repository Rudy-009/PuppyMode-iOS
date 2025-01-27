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
    }
    
    // MARK: - action
    private func setAction() {
        calendarView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func changeButtonTapped() {
        calendarView.blurBackgroundView.isHidden = false
        let modalVC = CalendarModalViewController(calendarView: calendarView)
        modalVC.modalPresentationStyle = .overFullScreen
        present(modalVC, animated: true)
    }

}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let formattedDate = dateFormatter.string(from: date)
        
        let detailVC = CalendarDetailViewController()
        detailVC.calendarDetailView.dateLabel.text = formattedDate
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
