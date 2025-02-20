//
//  DrinkingViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/24/25.
//

import UIKit
import Alamofire

class DrinkingViewController: UIViewController {

    private let drinkingView = DrinkingView()
    private var appointmentId: Int // 전달받은 appointmentId 저장
    
    init(appointmentId: Int) {
        self.appointmentId = appointmentId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = drinkingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        checkDrinkingStatus()
        
        drinkingView.endButton.addTarget(self, action: #selector(didTapEndButton), for: .touchUpInside)
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
        titleLabel.text = "술 마시는 중"
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
    
    @objc private func didTapBackButton() {
        if let navigationController = self.navigationController {
            // 네비게이션 스택에서 이전 화면으로 이동
            navigationController.popViewController(animated: true)
        } else {
            // 네비게이션 컨트롤러가 없으면 모달 닫기
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Connect Api
    // 술 약속 및 음주 상태 조회하기 API
    private func checkDrinkingStatus() {
        let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) ?? ""
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        let url = "\(K.String.puppymodeLink)/appointments/\(appointmentId)/status" // appointmentId는 전달받은 값
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: CheckDrinkingStatusResponse.self) { response in
            switch response.result {
            case .success(let data):
                if data.code == "SUCCESS_GET_APPOINTMENT_STATUS" {
                    print("술 약속 및 음주 상태 조회 성공!")
                    
                    // 뷰 업데이트
                    DispatchQueue.main.async {
                        self.updateDrinkingView(with: data.result)
                    }
                } else {
                    print("응답 코드가 SUCCESS_GET_APPOINTMENT_STATUS가 아닙니다.")
                }
            case .failure(let error):
                print("API 요청 실패:", error.localizedDescription)
            }
        }
    }
    
    // 음주 상태 현황 label 업데이트 함수
    private func updateDrinkingView(with result: DrinkingStatusResult?) {
        guard let result = result else { return }
        
        // progressNameLabel 업데이트
        drinkingView.progressNameLabel.text = "\(result.puppyName)가 지켜보고 있어요!"
        
        // progressTimeLabel 업데이트
        drinkingView.progressTimeLabel.text = "\(result.drinkingHours)시간 째 술마시는 중"
        
        // 이미지 애니메이션 시작
        if !result.drinkingImageUrls.isEmpty {
            startImageAnimation(with: result.drinkingImageUrls)
        }
    }
    
    private func startImageAnimation(with imageUrls: [String]) {
        var currentIndex = 0
        
        // 애니메이션을 위한 타이머 설정 (1초 간격으로 이미지 변경)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // 현재 인덱스의 URL로 이미지 로드
            let imageUrl = imageUrls[currentIndex]
            self.loadImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    self.drinkingView.imageView.image = image // 이미지 뷰 업데이트
                }
            }
            
            // 다음 인덱스로 이동 (순환)
            currentIndex = (currentIndex + 1) % imageUrls.count
        }
    }
    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("이미지 로드 실패:", error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    
    // 음주 상태 종료하기 API
    @objc private func didTapEndButton() {
        print("End button tapped!")
        
        guard let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            print("인증 토큰을 가져올 수 없습니다.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        // PATCH 요청 URL
        let url = "\(K.String.puppymodeLink)/appointments/\(appointmentId)/status"
        
        // 요청 본문 (음주 상태 종료)
        let parameters: [String: Any] = [
            "status": "COMPLETED" // 상태를 COMPLETED로 변경
        ]
        
        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: EndAppointmentResponse.self) { response in
            switch response.result {
            case .success(let data):
                if data.code == "SUCCESS_END_DRINKING_APPOINTMENT" {
                    print("음주 상태 종료 성공!")
                    
                    // 음주 종료 시간 출력
                    if let completedTime = data.result?.completedTime {
                        print("음주 종료 시점: \(completedTime)")
                    }
                    
                    // EndDrinkingViewController로 이동
                    DispatchQueue.main.async {
                        let endDrinkingVC = EndDrinkingViewController()
                        self.navigationController?.pushViewController(endDrinkingVC, animated: true)
                    }
                } else {
                    print("응답 코드가 SUCCESS_END_DRINKING_APPOINTMENT가 아닙니다.")
                }
            case .failure(let error):
                print("API 요청 실패:", error.localizedDescription)
            }
        }
    }
    
}
