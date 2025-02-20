//
//  DrinkingProgressBarView.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit
import Then

class DrinkingProgressBarView: UIView {

    private let containerView = UIView()
    
    // Progress Bar Title
    private let titleLabel = UILabel().then {
        $0.text = "나의 주량"
        $0.textAlignment = .left
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
    }

    // Progress Bar
    private let progressBar = UIProgressView(progressViewStyle: .default).then {
        $0.progress = 0.5 // Example progress (50%)
        
        $0.progressTintColor = UIColor(hex: "#73C8B1")
        $0.trackTintColor = UIColor(hex: "#F9F9F9")
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10.5
        $0.subviews[1].clipsToBounds = true
        $0.layer.sublayers?[1].cornerRadius = 10.5
    }

    // Safe Label
    private let safeLabel = UILabel().then {
        $0.text = "안전주량"
        
        $0.textColor = UIColor(hex: "#8A8A8E")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }

    // Danger Label
    private let dangerLabel = UILabel().then {
        $0.text = "치사량"
        
        $0.textColor = UIColor(hex: "#FF5353")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
    }
    
    // Safe Line and Text
    private let safeLine = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
    private let safeValueLabel = UILabel().then {
        $0.text = "1.5병\n8잔"
        $0.textColor = UIColor(hex: "#8A8A8E")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }

    // Danger Line and Text
    private let dangerLine = UIView().then {
        $0.backgroundColor = .systemRed
    }
    
    private let dangerValueLabel = UILabel().then {
        $0.text = "2.5병\n16잔"
        $0.textColor = UIColor(hex: "#8A8A8E")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }

    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Public Method to Update Progress and Labels
    func configure(progress: Float, safeText: String, dangerText: String) {
        progressBar.progress = progress
        safeValueLabel.text = safeText
        dangerValueLabel.text = dangerText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Calculate positions based on containerView's total width
        let safeOffset = containerView.frame.width * 0.74 // 70% of total container width
        let dangerOffset = containerView.frame.width * 0.95 // 90% of total container width
        
        // Update constraints for Safe Line
        safeLine.snp.updateConstraints { make in
            make.centerX.equalTo(progressBar.snp.leading).offset(safeOffset)
        }
        
        // Update constraints for Danger Line
        dangerLine.snp.updateConstraints { make in
            make.centerX.equalTo(progressBar.snp.leading).offset(dangerOffset)
        }
    }
    
    // Setup UI Elements
    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#FFFFFF")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(dangerLabel)
        containerView.addSubview(safeLabel)
        containerView.addSubview(progressBar)
        
        containerView.addSubview(safeLine)
        containerView.addSubview(dangerLine)
        
        containerView.addSubview(safeValueLabel)
        containerView.addSubview(dangerValueLabel)
    }

    // Setup Layout with SnapKit
    private func setupLayout() {
        
        // 컨테이너 뷰에 패딩 적용
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(19) // 패딩 값 설정 (19px)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
        }
        
        dangerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(24)
        }

        safeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalTo(dangerLabel.snp.left).offset(-20)
            make.height.equalTo(24)
        }

        progressBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(21)
        }
        
        safeLine.snp.makeConstraints { make in
            make.centerX.equalTo(progressBar.snp.leading)
            make.top.equalTo(progressBar.snp.bottom).offset(-20)
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        
        // Initial Danger Line Setup
        dangerLine.snp.makeConstraints { make in
            make.centerX.equalTo(progressBar.snp.leading)
            make.top.equalTo(progressBar.snp.bottom).offset(-20)
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        // Safe Value Label (Below Safe Line)
        safeValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeLine)
            make.top.equalTo(safeLine.snp.bottom).offset(5)
        }
        
        // Danger Value Label (Below Danger Line)
        dangerValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(dangerLine)
            make.top.equalTo(dangerLine.snp.bottom).offset(5)
        }
    }
}
