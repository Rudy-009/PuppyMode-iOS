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
    
    // 왼쪽
    private let leftButton = UIButton().then {
        $0.setImage(.iconCalendarLeft, for: .normal)
    }
    
    // 년도
    private let yearLabel = UILabel().then {
        $0.text = "2025"
        $0.textColor = UIColor(red: 0.055, green: 0.055, blue: 0.059, alpha: 1)
        
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 24)
    }
    
    // 오른쪽
    private let rightButton = UIButton().then {
        $0.setImage(.iconCalendarRight, for: .normal)
    }
    
    // 년도 선택 스택뷰
    public let yearStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    // 월 선택 컬렉션뷰
    public let monthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 0
    }).then {
        $0.isScrollEnabled = false
        $0.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.identifier)
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
    private func setStackView() {
        [leftButton, yearLabel, rightButton].forEach { yearStackView.addArrangedSubview($0) }
    }
    
    private func setView() {
        setStackView()
        
        [
            modalView,
            yearStackView,
            monthCollectionView
        ].forEach {
            addSubview($0)
        }
        
        modalView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(382)
        }
        
        yearStackView.snp.makeConstraints {
            $0.top.equalTo(modalView.snp.top).offset(20)
            $0.horizontalEdges.equalTo(modalView).inset(20)
            $0.height.equalTo(30)
        }
        
        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        yearLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        rightButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        monthCollectionView.snp.makeConstraints {
            $0.top.equalTo(yearStackView.snp.bottom).offset(19)
            $0.horizontalEdges.equalToSuperview().inset(37)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
    }
}
