//
//  CalendarModalViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 10/01/2025.
//

import UIKit

class CalendarModalViewController: UIViewController {
    private let calendarModalView = CalendarModalView()
    private weak var calendarView: CalendarView?
    
    init(calendarView: CalendarView) {
        self.calendarView = calendarView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarModalView
        
        setAction()
    }
    
    // MARK: - action
    private func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        calendarModalView.addGestureRecognizer(tapGesture)
        calendarModalView.isUserInteractionEnabled = true
    }
    
    @objc
    private func backgroundTapped() {
        self.calendarView?.blurBackgroundView.isHidden = true
        dismiss(animated: true)
    }

}
