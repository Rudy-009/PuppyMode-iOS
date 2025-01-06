//
//  BaseViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class BaseViewController: UITabBarController {
    private let homeVC = HomeViewController()
    private let socialVC = SocialViewController()
    private let calendarVC = CalendarViewController()
    private let settingVC = SettingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        socialVC.tabBarItem = UITabBarItem(title: "소셜", image: UIImage(systemName: "person.2.fill"), tag: 1)
        calendarVC.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), tag: 2)
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.fill"), tag: 3)
        
        self.viewControllers = [homeVC, socialVC, calendarVC, settingVC]
    }

}
