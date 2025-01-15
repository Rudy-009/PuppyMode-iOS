//
//  DrinkingInfoView.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit
import Then

class DrinkingInfoView: UIView {

    // Title Label
    let titleLabel = UILabel().then {
        $0.text = "주량 정보"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Blod", size: 24)
    }

    // Carousel (Image Scroll View)
    let carouselScrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }

    // Alcohol Percentage Label
    let alcoholNameLabel = UILabel().then {
        $0.text = "참이슬 후레쉬"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#8A8A8E")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    // Alcohol Percentage Label
    let alcoholPercentageLabel = UILabel().then {
        $0.text = "16.0도"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }

    // Progress Bar Title
    let progressBarTitleLabel = UILabel().then {
        $0.text = "나의 주량"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        $0.numberOfLines = 1
    }

    // Progress Bar
    let progressBar = UIProgressView(progressViewStyle: .default).then {
        $0.progress = 0.5 // Example progress (50%)
        $0.progressTintColor = UIColor.systemGreen
        $0.trackTintColor = UIColor.systemGray5
    }

    // Safe and Danger Labels
    let safeLabel = UILabel().then {
        $0.text = "안전주량"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray
    }

    let dangerLabel = UILabel().then {
        $0.text = "치사량"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemRed
    }

    // Bottom Button
    let makeAppointmentButton = UIButton(type: .system).then {
        $0.setTitle("오늘 술 마실 거에요!", for: .normal)
               
        $0.backgroundColor = UIColor(hex: "#73C8B1")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
        $0.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)

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
        self.backgroundColor = UIColor.white

        // Add subviews to the view hierarchy
        addSubview(titleLabel)
        addSubview(alcoholNameLabel)
        addSubview(alcoholPercentageLabel)
        addSubview(carouselScrollView)
        addSubview(progressBarTitleLabel)
        addSubview(progressBar)
        addSubview(safeLabel)
        addSubview(dangerLabel)
        addSubview(makeAppointmentButton)

        // Add example images to the carousel (replace with your own images)
        let images = ["chamisul", "chamisul", "chamisul"] // Replace with your image names in Assets.xcassets
        var previousImageView: UIImageView? = nil

        for imageName in images {
            let imageView = UIImageView().then {
                $0.image = UIImage(named: imageName)
                $0.contentMode = .scaleAspectFit
                $0.layer.borderWidth = 2
                $0.layer.borderColor = UIColor.systemBlue.cgColor
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = true
            }
            carouselScrollView.addSubview(imageView)

            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.snp.width).multipliedBy(0.6) // Adjust width as needed (60% of screen width)
                if let previousImageView = previousImageView {
                    make.leading.equalTo(previousImageView.snp.trailing).offset(20) // Space between images
                } else {
                    make.leading.equalToSuperview().offset(20) // First image starts with padding from the left
                }
            }
            previousImageView = imageView
        }

        previousImageView?.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20) // Last image ends with padding on the right
        }
    }

    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        alcoholNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.height.equalTo(20)
        }
        
        alcoholPercentageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.left.equalTo(alcoholNameLabel.snp.right).offset(50)
            make.height.equalTo(20)
        }

        carouselScrollView.snp.makeConstraints { make in
            make.top.equalTo(alcoholPercentageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150) // Adjust height as needed for carousel images
        }

        progressBarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(carouselScrollView.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }

        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressBarTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(10) // Adjust height as needed for progress bar thickness
        }

        safeLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(5)
            make.leading.equalTo(progressBar.snp.leading)
            make.height.equalTo(15)
        }

        dangerLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(5)
            make.trailing.equalTo(progressBar.snp.trailing)
            make.height.equalTo(15)
        }

        makeAppointmentButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40) // Adjust bottom spacing as needed for button placement
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60) // Adjust button height as needed for design consistency
        }
    }
}
