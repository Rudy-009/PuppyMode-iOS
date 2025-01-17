//
//  DecorationView.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit
import SnapKit

class DecorationView: UIView {
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: Puppy Image & Name
    
    lazy public var puppyImageButton = UIButton().then { button in
        button.setImage(UIImage(named: "HomeCharacterDefaultImage"), for: .normal)
    }
    
    lazy private var puppyNameLabel = UILabel().then { label in
        label.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        label.text = "이름"
    }
    
    public lazy var renamebutton = UIButton().then { button in
        button.setImage(UIImage(named: "renameButtonImage"), for: .normal)
    }
    
    lazy private var segmentScrollView = UIScrollView().then { scrollView in
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
    }
    
    lazy private var segmentControl = UISegmentedControl(items: ["모자", "얼굴", "옷", "집", "바닥", "장난감"]).then { segment in
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .clear
        segment.selectedSegmentTintColor = .gray
        
        // 배경과 구분선 이미지 제거
        segment.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        segment.apportionsSegmentWidthsByContent = true     // 글자 크기에 맞게 segment 너비 설정
        
        // 기본 상태 텍스트 속성 설정
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Regular", size: 15)
        ], for: .normal
        )
        
        // 선택된 상태 텍스트 속성 설정 (볼드체 및 밑줄 추가)
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Regular", size: 15)
        ], for: .selected
        )
    }
    
    lazy private var backgroundScrollView = UIScrollView().then { scrollview in
        scrollview.backgroundColor = .decorationBackground
        scrollview.layer.cornerRadius = 10
        scrollview.isScrollEnabled = true
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addComponents() {
        self.addSubview(puppyImageButton)
        puppyImageButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(247)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(36)
        }
        
        self.addSubview(puppyNameLabel)
        puppyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(puppyImageButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    
        self.addSubview(renamebutton)
        renamebutton.snp.makeConstraints { make in
            make.leading.equalTo(puppyNameLabel.snp.trailing).offset(6)
            make.width.height.equalTo(23)
            make.centerY.equalTo(puppyNameLabel)
        }
        
        
        self.addSubview(backgroundScrollView)
        backgroundScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(puppyNameLabel.snp.bottom).offset(30)
        }
        
     
          
        backgroundScrollView.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(32)
            make.width.greaterThanOrEqualTo(450)
        }
    }
}
