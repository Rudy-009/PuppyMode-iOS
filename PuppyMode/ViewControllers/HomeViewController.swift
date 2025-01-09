//
//  HomeViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = homeView
    }

}
