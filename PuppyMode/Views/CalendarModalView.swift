//
//  CalendarModalView.swift
//  PuppyMode
//
//  Created by 김미주 on 10/01/2025.
//

import UIKit

class CalendarModalView: UIView {
    // MARK: - view
    // 모달 뷰
    private let modalView = UIView().then {
        $0.backgroundColor = .white
        
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 232/255, green: 233/255, blue: 241/255, alpha: 1).cgColor
        
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - function
    private func setView() {
        [
            modalView
        ].forEach {
            addSubview($0)
        }
        
        modalView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(382)
        }
    }
}
