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
    }

}
