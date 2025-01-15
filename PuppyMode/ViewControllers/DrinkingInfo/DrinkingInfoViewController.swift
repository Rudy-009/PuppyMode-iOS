//
//  DrinkingInfoViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit

class DrinkingInfoViewController: UIViewController {
    
    // View 객체 생성
    private let drinkingInfoView = DrinkingInfoView()
    
    override func loadView() {
        self.view = drinkingInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupActions()
        configureData()
    }
    
    private func setupNavigationBar() {
        // 뒤로가기 버튼에 사용할 UIButton 생성
           let backButton = UIButton(type: .custom)
           backButton.setImage(UIImage(named: "left_arrow"), for: .normal) // 이미지 설정
           backButton.frame = CGRect(x: 0, y: 0, width: 13, height: 20) // 버튼 크기 설정
           backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

           // UIBarButtonItem에 UIButton을 customView로 설정
           let barButtonItem = UIBarButtonItem(customView: backButton)
           self.navigationItem.leftBarButtonItem = barButtonItem
        
        
        // 네비게이션 바 타이틀 설정
        self.title = "주량 정보"
        
        // 타이틀 가운데 정렬 및 스타일 설정
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#3C3C3C"), // 텍스트 색상
            .font: UIFont(name: "NotoSansKR-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium), // 폰트 설정
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center // 가운데 정렬
                paragraphStyle.lineHeightMultiple = 1.2 // Line height (120%)
                return paragraphStyle
            }()
        ]
        
    }
    
    // 뒤로가기 버튼 동작
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 버튼 액션 설정
    private func setupActions() {
        drinkingInfoView.makeAppointmentButton.addTarget(self, action: #selector(didTapMakeAppointmentButton), for: .touchUpInside)
    }
    
    @objc private func didTapMakeAppointmentButton() {
        print("오늘 술 마실 거에요! 버튼 클릭됨")
        let modalVC = AppointmentModalViewController()
        modalVC.modalPresentationStyle = .overFullScreen // 화면 전체를 덮는 스타일로 설정
        modalVC.modalTransitionStyle = .crossDissolve   // 부드러운 전환 효과 추가
        present(modalVC, animated: true, completion: nil) // 모달 표시
    }
    
    // 데이터 구성
    private func configureData() {
        drinkingInfoView.alcoholPercentageLabel.text = "16.0도"
        
        // 캐러셀 데이터 전달 및 업데이트
        let carouselData = ["chamisul", "saero", "chamisul", "saero"] // Example data (image names)
        drinkingInfoView.setCarouselData(carouselData)
    }
}
