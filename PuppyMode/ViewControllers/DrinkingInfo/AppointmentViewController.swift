//
//  AppointmentViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 2/13/25.
//

import UIKit

class AppointmentViewController: UIViewController, AddressSearchDelegate {

    private let appointmentView = AppointmentView()

    override func loadView() {
        self.view = appointmentView // View 연결
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupNavigationBar()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
    }
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        // Create a custom navigation bar container
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor(hex: "#FBFBFB")
        view.addSubview(navigationBar)
        
        // Add constraints for the navigation bar using SnapKit
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top) // safeAreaLayoutGuide 기준으로 설정
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56) // Adjust height as needed
        }
        
        // Create a title label for the navigation bar
        let titleLabel = UILabel()
        titleLabel.text = "술 약속"
        titleLabel.textColor = UIColor(hex: "#3C3C3C")
        titleLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .center
        navigationBar.addSubview(titleLabel)
        
        // Add constraints for the title label using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(navigationBar) // 네비게이션 바의 중앙에 위치
        }
        
        // Create a close button (back button) for the left side of the navigation bar
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "left_arrow"), for: .normal) // Replace with your back arrow image name
        closeButton.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        navigationBar.addSubview(closeButton)
        
        // Add constraints for the close button using SnapKit
        closeButton.snp.makeConstraints { make in
            make.leading.equalTo(navigationBar.snp.leading).offset(16) // safeAreaLayoutGuide와 동일한 위치로 설정
            make.centerY.equalTo(navigationBar) // 네비게이션 바의 수직 중앙에 위치
            make.width.equalTo(13)
            make.height.equalTo(20)
        }
    }

    // MARK: - Setup Actions

    private func setupActions() {
        appointmentView.timeButton.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        appointmentView.addressButton.addTarget(self, action: #selector(didTapAddressButton), for: .touchUpInside)
    }

    // MARK: - Button Actions

    // 뒤로가기 버튼 동작
    @objc private func didTapBackButton() {
        if let navigationController = self.navigationController {
            // 네비게이션 스택에서 이전 화면으로 이동
            navigationController.popViewController(animated: true)
        } else {
            // 네비게이션 컨트롤러가 없으면 모달 닫기
            dismiss(animated: true, completion: nil)
        }
    }
    
    // 시간 선택 버튼 이벤트
    @objc private func didTapTimeButton() {
        print("시간 선택 버튼 클릭됨")
        
        let datePickerVC = DatePickerModalViewController()
        
        // 시간 선택 콜백 설정
        datePickerVC.onTimeSelected = { [weak self] selectedTime in
            guard let self = self else { return }
            
            self.appointmentView.timeButton.setTitle(selectedTime, for: .normal)
            self.appointmentView.timeButton.setTitleColor(.black, for: .normal)
            
            print("선택된 시간:", selectedTime)
        }
        
        // iOS 15 이상: UISheetPresentationController 사용
        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // 중간 크기와 전체 화면 크기 제공
            sheet.prefersGrabberVisible = true   // 위쪽에 드래그 바 표시
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 스크롤 확장 비활성화
        }
        
        datePickerVC.modalPresentationStyle = .pageSheet // 시트 스타일 설정
        self.present(datePickerVC, animated: true, completion: nil) // 모달 표시
    }

    // 주소 선택 버튼 이벤트
    @objc private func didTapAddressButton() {
        print("주소 선택 버튼 클릭됨")
        
        // 주소 검색 화면 표시
        let addressSearchVC = AddressSearchModalViewController()
        addressSearchVC.delegate = self // Delegate 설정
        addressSearchVC.modalPresentationStyle = .overFullScreen
        addressSearchVC.modalTransitionStyle = .crossDissolve
        
        present(addressSearchVC, animated: true, completion: nil)
    }

    // MARK: - AddressSearchDelegate

    func didSelectAddress(_ roadAddress: String) {
        print("선택된 도로명 주소:", roadAddress)
        
        // 선택된 주소를 버튼에 업데이트
        appointmentView.addressButton.setTitle(roadAddress, for: .normal)
        appointmentView.addressButton.setTitleColor(.black, for: .normal)
    }
}
