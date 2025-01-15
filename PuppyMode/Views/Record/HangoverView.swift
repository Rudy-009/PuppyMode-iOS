//
//  HangoverView.swift
//  PuppyMode
//
//  Created by 김미주 on 15/01/2025.
//

import UIKit
import Then
import SnapKit

class HangoverView: UIView {
    // MARK: - view
    // 뒤로가기
    public let backButton = UIButton().then {
        $0.setImage(.iconBack, for: .normal)
    }
    
    // 타이틀
    private let titleLabel = UILabel().then {
        $0.text = "1. 숙취 선택"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    // 질문 + 설명
    
    // 숙취 컬렉션뷰
    
    // 버튼 스택뷰
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - function
    private func setView() {
        [
            backButton,
            titleLabel
        ].forEach {
            addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
            $0.left.equalToSuperview().offset(37)
            $0.width.equalTo(13)
            $0.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton)
        }
    }
}
