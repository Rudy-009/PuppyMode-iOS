//
//  AppointmentModalViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit
import Alamofire

class AppointmentModalViewController: UIViewController, AddressSearchDelegate {
    
    // UI Elements
    private let blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)).then {
        $0.alpha = 0.5 // 블러 투명도 설정
        
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = UIColor(hex: "#FFFFFF")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.text = "술 마시러 가시나요?"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "정보를 입력해 주시면 멍멍이가 도와드릴게요!"
        
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "#777777")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    private let timePickerLabel = UILabel().then {
        $0.text = "시간"
        
        $0.textAlignment = .left
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    private let timeButton = UIButton(type: .system).then {
        $0.setTitle("시간을 선택해주세요", for: .normal)
        $0.setTitleColor(UIColor(hex: "#AFAFAF"), for: .normal)
        $0.backgroundColor = UIColor(hex: "#FFFFFF") // Set background color to white
        $0.layer.cornerRadius = 0 // No rounded corners
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        $0.contentHorizontalAlignment = .left // Align text to the left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // Add padding to the left
    }
    
    // Add a bottom border to the button
    private func addBottomBorder(to button: UIButton) {
        let border = UIView()
        border.backgroundColor = UIColor(hex: "#D9D9D9") // Border color
        button.addSubview(border)
        
        border.snp.makeConstraints { make in
            make.height.equalTo(1) // Border thickness
            make.leading.trailing.equalToSuperview() // Full width of the button
            make.bottom.equalToSuperview() // Align at the bottom
        }
    }
    
    private let placePickerLabel = UILabel().then {
        $0.text = "장소"
        
        $0.textAlignment = .left
        $0.textColor = UIColor(hex: "#3C3C3C")
        $0.font = UIFont(name: "NotoSansKR-Medium", size: 20)
    }
    
    private let locationTextField = UITextField().then {
        $0.placeholder = "장소를 입력하세요"
        $0.textColor = UIColor(hex: "#AFAFAF")
        $0.borderStyle = .none // Remove default border
        $0.backgroundColor = UIColor(hex: "#FFFFFF") // Set background color to white
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .left // Align text to the left

        // Add left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // Width = 10 for padding
        $0.leftView = paddingView
        $0.leftViewMode = .always // Ensure the padding view is always visible
    }
    
    private let detailAddressTextField = UITextField().then {
        $0.placeholder = "상세 주소를 입력하세요"
        $0.textColor = UIColor(hex: "#AFAFAF")
        $0.borderStyle = .none // Remove default border
        $0.backgroundColor = UIColor(hex: "#FFFFFF") // Set background color to white
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .left // Align text to the left

        // Add left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // Width = 10 for padding
        $0.leftView = paddingView
        $0.leftViewMode = .always // Ensure the padding view is always visible
    }

    // Add a bottom border to the text field
    private func addBottomBorder(to textField: UITextField) {
        let border = UIView()
        border.backgroundColor = UIColor(hex: "#D9D9D9") // Border color
        textField.addSubview(border)
        
        border.snp.makeConstraints { make in
            make.height.equalTo(1) // Border thickness
            make.leading.trailing.equalToSuperview() // Full width of the text field
            make.bottom.equalToSuperview() // Align at the bottom
        }
    }
    
    private let cancelButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(hex: "#E2E2E2")
        $0.layer.cornerRadius = 10
        
        $0.setTitle("취소하기", for: .normal)
        $0.setTitleColor(UIColor(hex: "#777777"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    private let confirmButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(hex: "#73C8B1")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
        $0.setTitle("선택 완료", for: .normal)
        $0.setTitleColor(UIColor(hex: "#3F3F3F"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        
        // Button Actions
        timeButton.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        locationTextField.addTarget(self, action: #selector(didTapLocationTextField), for: .touchDown)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.clear // 배경 투명 처리
        
        // Add blur background and container view
        view.addSubview(blurBackgroundView)
        view.addSubview(containerView)
        
        // Add elements to container view
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        containerView.addSubview(timePickerLabel)
        containerView.addSubview(timeButton)
        containerView.addSubview(placePickerLabel)
        containerView.addSubview(locationTextField)
        containerView.addSubview(detailAddressTextField)
        
        containerView.addSubview(cancelButton)
        containerView.addSubview(confirmButton)
        
        addBottomBorder(to: timeButton)
        addBottomBorder(to: locationTextField)
        addBottomBorder(to: detailAddressTextField)
    }
    
    private func setupLayout() {
        
        blurBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 전체 화면 크기와 동일하게 설정
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview() // 화면 중앙에 위치
            make.height.equalTo(450) // 고정 높이 설정
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        timePickerLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(36)
            make.left.equalToSuperview().offset(21)
            make.height.equalTo(25)
        }
        
        timeButton.snp.makeConstraints { make in
            make.top.equalTo(timePickerLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        placePickerLabel.snp.makeConstraints { make in
            make.top.equalTo(timeButton.snp.bottom).offset(33)
            make.left.equalToSuperview().offset(21)
            make.height.equalTo(25)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(placePickerLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        detailAddressTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(10) // locationTextField 아래에 배치
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(detailAddressTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(detailAddressTextField.snp.bottom).offset(30)
            make.left.equalTo(cancelButton.snp.right).offset(11)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
    }
    
    // MARK: - Button Actions
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true, completion: nil) // 모달 닫기
    }
    
    @objc private func didTapConfirmButton() {
        // 필수 필드 검증
        guard let selectedTime = timeButton.title(for: .normal), selectedTime != "시간을 선택해주세요",
              let location = locationTextField.text, !location.isEmpty,
              let locationDetail = detailAddressTextField.text, !locationDetail.isEmpty,
              let userIdString = KeychainService.get(key: UserInfoKey.userId.rawValue),
              let userId = Int(userIdString) else {
            print("필수 정보가 누락되었습니다.")
            return
        }

        // 날짜 포맷 변환 (ISO8601)
        let formatter = ISO8601DateFormatter()
        let dateTime = formatter.string(from: Date()) // 실제 선택된 시간 사용 시 수정 필요*

        // API 파라미터 (임시 하드코딩 값 포함)
        let parameters: [String: Any] = [
            "dateTime": dateTime,
            "latitude": 37.498095, // 실제 좌표 값으로 대체 필요
            "longitude": 127.027610,
            "address": location,
            "locationName": location,
            "userId": userId
        ]

        // 헤더 설정
        let fcmToken = KeychainService.get(key: UserInfoKey.jwt.rawValue) ?? ""
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(fcmToken)"
        ]

        // API 요청
        AF.request(K.String.puppymodeLink + "/appointments",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .responseDecodable(of: CreateAppointmentResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if data.code == "SUCCESS_POST_APPOINTMENT" {
                        print("약속 생성 성공! ID: \(data.result?.appointmentId ?? 0)")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        print("에러 발생: \(data.message)")
                    }
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                }
            }
    }
    
    @objc private func didTapTimeButton() {
        // Create a container view for the picker and toolbar
        let pickerContainerView = UIView()
        pickerContainerView.backgroundColor = UIColor.white
        pickerContainerView.layer.cornerRadius = 10
        pickerContainerView.clipsToBounds = true
        
        
        // Create UIDatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        pickerContainerView.addSubview(datePicker)
        
        // Create Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Customizing the toolbar appearance
        toolbar.barTintColor = UIColor(hex: "#FFFFFF") // Toolbar 배경색
        toolbar.tintColor = UIColor(hex: "#3C3C3C")   // 버튼 텍스트 색상
        
        // Toolbar buttons
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancelPicker))
        cancelButton.setTitleTextAttributes([.font: UIFont(name: "NotoSansKR-Medium", size: 14)!], for: .normal)
        
        let confirmButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(didTapConfirmPicker))
        confirmButton.setTitleTextAttributes([.font: UIFont(name: "NotoSansKR-Medium", size: 14)!], for: .normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, flexibleSpace, confirmButton], animated: false)
        
        pickerContainerView.addSubview(toolbar)
        
        // Add to the main view
        view.addSubview(pickerContainerView)
        
        // Layout for pickerContainerView
        pickerContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300) // Adjust height as needed
            make.bottom.equalTo(self.view.snp.bottom).offset(300) // Start below the screen
        }
        
        // Layout for datePicker
        datePicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(216) // Standard height for UIDatePicker
        }
        
        // Layout for toolbar
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(datePicker.snp.top).offset(-10)
            make.height.equalTo(44) // Standard height for toolbar
        }
        
        // Animate Picker Container View to slide up from the bottom
        UIView.animate(withDuration: 0.3) {
            pickerContainerView.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom) // Move to the bottom of the screen (visible)
            }
            self.view.layoutIfNeeded() // Apply layout changes immediately during animation
        }
    }

    @objc private func didTapCancelPicker() {
        guard let pickerContainerView = view.subviews.last else { return }

            UIView.animate(withDuration: 0.3, animations: {
                pickerContainerView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.snp.bottom).offset(300) // Slide down below the screen
                }
                self.view.layoutIfNeeded() // Apply layout changes immediately during animation
            }) { _ in
                pickerContainerView.removeFromSuperview() // Remove from superview after animation completes
           }
    }
    
    @objc private func didTapConfirmPicker() {
        guard let pickerContainerView = view.subviews.last as? UIView,
              let datePicker = pickerContainerView.subviews.compactMap({ $0 as? UIDatePicker }).first else { return }
        
        // 선택된 시간 가져오기
        let selectedTime = datePicker.date
        
        // Format the selected time and set it to the button title
        let formatter = DateFormatter()
        formatter.timeStyle = .short // Short style (e.g., "오후 11:00")
        
        timeButton.setTitle(formatter.string(from: selectedTime), for: .normal)
        
        print("선택된 시간:", formatter.string(from: selectedTime))
        
        // Picker를 닫습니다.
        pickerContainerView.removeFromSuperview()
    }
    
    func didSelectAddress(_ roadAddress: String) {
        locationTextField.text = roadAddress // 선택된 도로명 주소를 텍스트 필드에 표시
    }
    
    @objc private func didTapLocationTextField() {
        let addressSearchVC = AddressSearchModalViewController()
        addressSearchVC.delegate = self // Delegate 설정
        addressSearchVC.modalPresentationStyle = .overFullScreen
        addressSearchVC.modalTransitionStyle = .crossDissolve
        
        present(addressSearchVC, animated: true, completion: nil)
    }
}
