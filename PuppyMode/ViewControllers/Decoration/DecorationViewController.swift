//
//  DecorationViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit

class DecorationViewController: UIViewController {
    
    private lazy var decorationView: DecorationView = {
        let view = DecorationView()
        
        view.renamebutton.addTarget(self, action: #selector(renameButtonTapped), for: .touchUpInside)

        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = decorationView
        
        setupNavigationBar(title: "꾸미기", action: #selector(customBackButtonTapped))
        
    }
    
    @objc func renameButtonTapped() {
        let renameVC = RenameViewController()
        navigationController?.pushViewController(renameVC, animated: true)
    }

}
