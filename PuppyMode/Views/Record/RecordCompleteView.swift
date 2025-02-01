//
//  RecordCompleteView.swift
//  PuppyMode
//
//  Created by 박준석 on 1/27/25.
//

import UIKit
import SnapKit

class RecordCompleteView: UIView {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기록 완료"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.235, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "주량을 잘 조절해서 마셨네요!"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    let steakImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "steak_image") // Replace with your steak image asset name
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let rewardLabel: UILabel = {
        let label = UILabel()
        label.text = "소고기를 획득했어요!"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("먹이주러 가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 115/255, green: 200/255, blue: 177/255, alpha: 1) // Match your design color
        button.layer.cornerRadius = 10
        button.titleLabel?.font =  UIFont(name: "NotoSansKR-Regular", size: 15)
        return button
    }()
    
    let progressComponentView = ProgressComponentView()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views and Layouts
    private func setupViews() {
        
        // Add subviews to the view hierarchy
        [titleLabel, messageLabel, steakImageView, rewardLabel, actionButton, progressComponentView].forEach { addSubview($0) }
        
        // Set constraints using SnapKit
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
        }
        
        steakImageView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(250)
        }
        
        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(steakImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(rewardLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200) // 버튼 너비
            make.height.equalTo(44) // 버튼 높이
        }
        
        progressComponentView.snp.makeConstraints{ make in
            make.top.equalTo(actionButton.snp.bottom).offset(95)
            make.left.equalToSuperview().offset(40)
        }
       
    }
}

class ProgressComponentView: UIView {
    
    // MARK: - UI Components
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Level 1 아기사자 포메라니안"
        label.font = UIFont(name: "SB Aggro", size: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(red: 115/255, green: 200/255, blue: 177/255, alpha: 1) // Match your design color
        progressView.trackTintColor = UIColor.lightGray
        progressView.progress = 0.55 // Set initial progress (55%)
        progressView.layer.cornerRadius = 30
        return progressView
    }()
    
    private let progressPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "55%"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white // Set background color to white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views and Layouts
    private func setupViews() {
        
        // Add subviews to the view hierarchy
        [progressLabel, progressBar, progressPercentageLabel].forEach { addSubview($0) }
        
        // Set constraints using SnapKit
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        progressPercentageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(progressLabel)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(290)
            make.height.equalTo(21)
        }
    }
    
    // MARK: - Public Methods to Update Progress
    func updateProgress(to value: Float, percentageText: String) {
        progressBar.progress = value
        progressPercentageLabel.text = percentageText
    }
}
