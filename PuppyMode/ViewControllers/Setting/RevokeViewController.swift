//
//  RevokeViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit

class RevokeViewController: UIViewController {
    
    let revokeView = RevokeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = revokeView
    }
    
}


