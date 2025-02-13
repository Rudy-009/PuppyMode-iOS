//
//  AppointmentView.swift
//  PuppyMode
//
//  Created by 박준석 on 2/13/25.
//

import UIKit
import SnapKit
import Then

class AppointmentView: UIView {
    
    // MARK: - UI Components
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.white // 흰색 배경
        $0.layer.cornerRadius = 10         // 둥근 테두리
        $0.layer.borderWidth = 1           // 테두리 두께
        $0.layer.borderColor = UIColor.lightGray.cgColor // 회색 테두리 색상
        $0.clipsToBounds = true            // 내용이 테두리를 넘지 않도록 설정
    }
    
    
    let titleLabel = UILabel().then {
        $0.text = "술 약속"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2024.05.05" // 예시 날짜
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor.gray
        $0.textAlignment = .center
    }
    
    let questionLabel = UILabel().then {
        $0.text = "술 마시러 가시나요?"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
    }
    
    let subQuestionLabel = UILabel().then {
        $0.text = "정보를 입력해 주시면 제가 도와드릴게요!"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.gray
        $0.textAlignment = .center
    }
    
    let timeButton = UIButton(type: .system).then {
        $0.setTitle("시간을 선택해주세요", for: .normal)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.contentHorizontalAlignment = .left
    }
    
    let timeArrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = UIColor.gray
    }
    
    let addressButton = UIButton(type: .system).then {
        $0.setTitle("장소를 선택해주세요", for: .normal)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.contentHorizontalAlignment = .left
    }
    
    let addressArrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = UIColor.gray
    }
    
    let detailAddressTextField = UITextField().then {
        $0.placeholder = "상세주소를 입력해주세요"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.borderStyle = .none
    }
    
    private let divider1 = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    private let divider2 = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    private let detailAddressDivider = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5) // 밑줄 색상
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        
        addSubview(dateLabel)
        
        addSubview(containerView) // 컨테이너 추가
        
        containerView.addSubview(questionLabel)
        containerView.addSubview(subQuestionLabel)
        
        containerView.addSubview(timeButton)
        containerView.addSubview(timeArrowImageView)
        
        containerView.addSubview(divider1)
        
        containerView.addSubview(addressButton)
        containerView.addSubview(addressArrowImageView)
        
        containerView.addSubview(divider2)
        
        containerView.addSubview(detailAddressTextField)
        containerView.addSubview(detailAddressDivider)
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        
        dateLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20) // 좌우 여백 설정
            make.top.equalToSuperview().offset(250)            // 상단 여백 설정
            make.height.equalTo(300)                           // 높이 설정 (필요 시 조정 가능)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20)
            make.centerX.equalTo(containerView)
            make.height.equalTo(24)
        }
        
        subQuestionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(8)
            make.centerX.equalTo(containerView)
            make.height.equalTo(20)
        }
        
        timeButton.snp.makeConstraints { make in
            make.top.equalTo(subQuestionLabel.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(timeArrowImageView.snp.leading).offset(-10)
            make.height.equalTo(40)
        }
        
        timeArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(timeButton)
            make.trailing.equalTo(containerView).offset(-20)
            make.width.height.equalTo(16)
        }

        divider1.snp.makeConstraints { make in
            make.top.equalTo(timeButton.snp.bottom).offset(8)
            make.leading.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(1)
        }

        addressButton.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(addressArrowImageView.snp.leading).offset(-10)
            make.height.equalTo(40)
        }

        addressArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(addressButton)
            make.trailing.equalTo(containerView).offset(-20)
            make.width.height.equalTo(16)
        }

        divider2.snp.makeConstraints { make in
            make.top.equalTo(addressButton.snp.bottom).offset(8)
            make.leading.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(1)
        }

        detailAddressTextField.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(8)
            make.leading.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(40)
        }
        
        detailAddressDivider.snp.makeConstraints { make in
            make.top.equalTo(detailAddressTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(1)
        }
    }
}

