//
//  RenameViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/14/25.
//

import UIKit

class RenameViewController: UIViewController {
    
    private lazy var renameView: RenameView = {
        let view = RenameView()
        
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = renameView
        
        setupNavigationBar(title: "이름 수정", action: #selector(customBackButtonTapped))

    }
}
