//
//  CalendarViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import FSCalendar
import Alamofire

class CalendarViewController: UIViewController {
    private let calendarView = CalendarView()
    private var drinkRecords: [String: DrinkRecord] = [:] // 날짜별 상태 저장

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        
        setDelegate()
        setAction()
        fetchDrinkRecords(for: calendarView.calendar.currentPage)
    }
    
    // MARK: - function
    private func setDelegate() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
    }
    
    private func fetchDrinkRecords(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let monthString = dateFormatter.string(from: date)
        
        let url = "https://puppy-mode.site/calendar?month=\(monthString)"
        
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
            print("JWT Token not found")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(jwt)"]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CalendarResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.processDrinkRecords(data.result)
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    private func processDrinkRecords(_ records: [DrinkRecord]) {
        drinkRecords.removeAll()
        for record in records {
            if record.drinkHistoryId != nil {
                drinkRecords[record.drinkDate] = record
            }
        }
        calendarView.calendar.reloadData()
    }
    
    // MARK: - action
    private func setAction() {
        calendarView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        calendarView.changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        calendarView.afterChangeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        calendarView.dateView.recordButton.backView.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.calendarView.yearLabel.isHidden = false
        self.calendarView.monthLabel.isHidden = false
        self.calendarView.changeButton.isHidden = false
        
        self.calendarView.backButton.isHidden = true
        self.calendarView.afterYearLabel.isHidden = true
        self.calendarView.afterMonthLabel.isHidden = true
        self.calendarView.afterChangeButton.isHidden = true
        
        self.calendarView.dateView.isHidden = true
        
        self.calendarView.updateCalendarScope(to: .month)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.calendarView.calendar.transform = .identity
            self.calendarView.dateView.transform = .identity
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
    
    @objc
    private func recordButtonTapped() {
        let detailVC = CalendarDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}

// MARK: - extension
extension CalendarViewController: FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let formattedDate = dateFormatter.string(from: date)
        
        calendarView.dateView.dateLabel.text = formattedDate
        
        UIView.animate(withDuration: 0.3, animations: {
            self.calendarView.yearLabel.isHidden = true
            self.calendarView.monthLabel.isHidden = true
            self.calendarView.changeButton.isHidden = true
            
            self.calendarView.backButton.isHidden = false
            self.calendarView.afterYearLabel.isHidden = false
            self.calendarView.afterMonthLabel.isHidden = false
            self.calendarView.afterChangeButton.isHidden = false
            
            self.calendarView.dateView.isHidden = false
            
            self.calendarView.calendar.transform = CGAffineTransform(translationX: 0, y: -125)
            self.calendarView.dateView.transform = CGAffineTransform(translationX: 0, y: -145)
        })
        
        self.calendarView.updateCalendarScope(to: .week)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        return drinkRecords[dateString] != nil ? 1 : 0
    }
    
    // 이벤트 표시
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if drinkRecords[dateString] != nil {
            return [.main]
        }
        return nil
    }
    
    // 이벤트 점 위치 조정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -3)
    }
    
    // 선택된 날짜 표시 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .black
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        fetchDrinkRecords(for: calendar.currentPage)
        calendarView.updateMonthLabel(for: calendar.currentPage)
    }
}
