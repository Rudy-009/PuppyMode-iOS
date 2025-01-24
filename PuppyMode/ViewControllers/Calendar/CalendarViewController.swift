//
//  CalendarViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class CalendarViewController: UIViewController {
    private let calendarView = CalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        
        setAction()
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
