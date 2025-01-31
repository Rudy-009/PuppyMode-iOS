//
//  EndDrinkingView.swift
//  PuppyMode
//
//  Created by 박준석 on 1/31/25.
//

import UIKit

class EndDrinkingView: UIView {

    // Dog Image
    private let dogImageView = UIImageView().then {
        $0.image = UIImage(named: "drinkingPuppy") // Replace with your actual image name
        $0.contentMode = .scaleAspectFit
    }

    // Title Label
    let titleLabel = UILabel().then {
        $0.text = "음주 종료"
        $0.textAlignment = .center
        
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }

    // Progress Label
    let finshTitleLabel = UILabel().then {
        $0.text = "즐거운 시간 보내셨나요?"
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    // Progress Label
    let finshSubtitleLabel = UILabel().then {
        $0.text = "내일 저한테 꼭 얼마나 마셨는지 알려주세요!"
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#8A8A8E")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
    }

    let okayButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        $0.backgroundColor = UIColor(hex: "#73C8B1")
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 18)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#FBFBFB")

        addSubview(dogImageView)
        addSubview(finshTitleLabel)
        addSubview(finshSubtitleLabel)
        
        addSubview(okayButton)
    }

    private func setupLayout() {

        dogImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(165)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(250) // Adjust size as needed
        }

        finshTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dogImageView.snp.bottom).offset(47)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        finshSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(finshTitleLabel.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        okayButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
