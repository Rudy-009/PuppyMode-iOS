//
//  CalendarDetailViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 28/01/2025.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    public let calendarDetailView = CalendarDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarDetailView
        
        setAction()
    }
    
    // MARK: - action
    private func setAction() {
        calendarDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
