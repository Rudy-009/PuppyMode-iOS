//
//  PuppySelectionViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/26/25.
//

import UIKit

class PuppySelectionViewController: UIViewController {

    private let puppySelectionView = PuppySelectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = puppySelectionView
    }
    

}
