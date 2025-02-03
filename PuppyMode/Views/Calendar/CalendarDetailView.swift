//
//  CalendarDetailView.swift
//  PuppyMode
//
//  Created by 김미주 on 28/01/2025.
//

import UIKit
import Then
import SnapKit

class CalendarDetailView: UIView {
    // MARK: - view
    // 뒤로가기
    public let backButton = UIButton().then {
        $0.setImage(.iconBack, for: .normal)
    }
    
    // 타이틀
    private let titleLabel = UILabel().then {
        $0.text = "음주 달력"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    // 날짜
    public let dateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    // 배경
    private let whiteBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private let backgroundLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.953, green: 0.957, blue: 0.965, alpha: 1)
    }
    
    // 섭취량
    private let intakeLabel = UILabel().then {
        $0.text = "섭취량"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
    }
    
    private let progressView = UIProgressView().then {
        $0.progressTintColor = .main
        $0.trackTintColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10.5
        $0.subviews[1].clipsToBounds = true
        $0.layer.sublayers?[1].cornerRadius = 10.5
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.837, green: 0.837, blue: 0.837, alpha: 1).cgColor
        
        $0.progress = 0.3
    }
    
    private let progressViewShadow = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.5
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    // 안전주량
    private let safeLabel = UILabel().then {
        $0.text = "안전주량"
        $0.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.557, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    private let safePointImage = UIImageView().then {
        $0.image = .imgProgressPointer
    }
    
    private let safeBottleLabel = UILabel().then {
        $0.text = "1.5병"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
    
    private let safeGlassLabel = UILabel().then {
        $0.text = "5잔"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
    
    // 치사량
    private let deadLabel = UILabel().then {
        $0.text = "치사량"
        $0.textColor = UIColor(red: 1, green: 0.327, blue: 0.327, alpha: 1)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    private let deadPointImage = UIImageView().then {
        $0.image = .imgProgressPointer
    }
    
    private let deadBottleLabel = UILabel().then {
        $0.text = "2.5병"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
    
    private let deadGlassLabel = UILabel().then {
        $0.text = "16잔"
        $0.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
    
    // 테이블뷰
    
    // 먹이 보기 버튼
    
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
            titleLabel,
            dateLabel,
            whiteBackgroundView, backgroundLine,
            intakeLabel, progressViewShadow, progressView,
            safeLabel, safePointImage, safeBottleLabel, safeGlassLabel,
            deadLabel, deadPointImage, deadBottleLabel, deadGlassLabel,
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
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
        }
        
        whiteBackgroundView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().offset(-174)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        backgroundLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(whiteBackgroundView)
            $0.top.equalTo(whiteBackgroundView.snp.top).offset(206)
        }
        
        intakeLabel.snp.makeConstraints {
            $0.top.equalTo(whiteBackgroundView.snp.top).offset(34)
            $0.left.equalTo(whiteBackgroundView.snp.left).offset(21)
        }
        
        progressViewShadow.snp.makeConstraints {
            $0.top.equalTo(intakeLabel.snp.bottom).offset(33)
            $0.horizontalEdges.equalTo(whiteBackgroundView).inset(14)
            $0.height.equalTo(21)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(intakeLabel.snp.bottom).offset(33)
            $0.horizontalEdges.equalTo(whiteBackgroundView).inset(14)
            $0.height.equalTo(21)
        }
        
        safeLabel.snp.makeConstraints {
            $0.centerY.equalTo(intakeLabel)
            $0.right.equalTo(deadLabel.snp.left).offset(-16)
        }
        
        safePointImage.snp.makeConstraints {
            $0.centerX.equalTo(safeLabel)
            $0.centerY.equalTo(progressView)
        }
        
        safeBottleLabel.snp.makeConstraints {
            $0.top.equalTo(safePointImage.snp.bottom).offset(20)
            $0.centerX.equalTo(safePointImage)
        }
        
        safeGlassLabel.snp.makeConstraints {
            $0.top.equalTo(safeBottleLabel.snp.bottom)
            $0.centerX.equalTo(safePointImage)
        }
        
        deadLabel.snp.makeConstraints {
            $0.centerY.equalTo(intakeLabel)
            $0.right.equalTo(whiteBackgroundView.snp.right).offset(-11)
        }
        
        deadPointImage.snp.makeConstraints {
            $0.centerX.equalTo(deadLabel)
            $0.centerY.equalTo(progressView)
        }
        
        deadBottleLabel.snp.makeConstraints {
            $0.top.equalTo(deadPointImage.snp.bottom).offset(20)
            $0.centerX.equalTo(deadPointImage)
        }
        
        deadGlassLabel.snp.makeConstraints {
            $0.top.equalTo(deadBottleLabel.snp.bottom)
            $0.centerX.equalTo(deadPointImage)
        }
    }
}

import SwiftUI
#Preview {
    CalendarDetailView()
}
