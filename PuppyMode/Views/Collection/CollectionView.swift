//
//  CollectionView.swift
//  PuppyMode
//
//  Created by 김민지 on 1/21/25.
//

import UIKit
import Then

class CollectionView: UIView {
    
    public lazy var collectionTableView = UITableView().then { tableView in
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.separatorStyle = .none

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        addComponents()
    }
    
    private func addComponents() {
        self.addSubview(collectionTableView)
        
        collectionTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalToSuperview().offset(133)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
