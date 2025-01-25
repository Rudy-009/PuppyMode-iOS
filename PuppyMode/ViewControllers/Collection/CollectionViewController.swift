//
//  CollectionViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/21/25.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private lazy var collectionView: CollectionView = {
        let view = CollectionView()
    
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = collectionView
        
        setupNavigationBar(title: "컬렉션", action: #selector(customBackButtonTapped))
        
    }
    
}
