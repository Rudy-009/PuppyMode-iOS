//
//  HomeViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import CoreLocation // 현재 위치 확인
import Alamofire

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    private var currentIndex = 0
    private var animationTimer: Timer?
    
    private var timer: Timer?
    private var remainingTime: Int = 1 // 24시간 = 86400 (초 단위)
    public var coinAlermButton = AlermView()
    
    private let locationManager = CLLocationManager()
    private var currentLatitude: Double?    // 위도 정보
    private var currentLongitude: Double?   // 경도 정보
    
    public var appointmentId: Int?
    public var ongoingAppointmentId: Int? // 현재 진행중인 술 약속 id

    let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = homeView
        self.navigationController?.isNavigationBarHidden = true
        
        setupLocationManager()
        self.defineButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // getPupptInfo()
        
        // 홈 화면에 접속할 떄 마다 가장 가까운 예약된 술 약속 확인 && 음주 중인지 검증
        handleAppointments()
        
        func handleAppointments() {
            // 오늘 날짜 가져오기
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todayStr = dateFormatter.string(from: currentDate)
            
            // GET /appointments API 호출
            fetchAppointments { [weak self] appointments in
                guard let self = self else { return }
                
                // 오늘 날짜의 ONGOING 상태 약속 찾기
                print("오늘 날짜 : ", todayStr)
                print("전체 술 약속 : ", appointments)
                if let ongoingAppointment = appointments.first(where: { appointment in
                    let appointmentDate = String(appointment.dateTime.prefix(10)) // "YYYY-MM-DD" 추출
                    return appointmentDate == todayStr && appointment.status == "ongoing"
                }) {
                    print("오늘의 ONGOING 약속:", ongoingAppointment)
                    
                    // ONGOING 상태인 경우 ID 저장
                    self.ongoingAppointmentId = ongoingAppointment.appointmentId
                    
                    // ONGOING 상태인 경우 버튼 업데이트
                    DispatchQueue.main.async {
                        self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "술 마시는 중")
                        self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "...")
                        self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#C3E9DF"))
                    }
                } else {
                    print("오늘 날짜의 ONGOING 약속이 없습니다.")
                    
                    // 가장 가까운 SCHEDULED 상태 약속 확인
                    self.checkNearestScheduledAppointment { nearestAppointmentId in
                        guard let nearestAppointmentId = nearestAppointmentId else {
                            print("가장 가까운 예약된 술 약속이 없습니다.")
                            self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "음주 기록")
                            self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "어제 마셨어요")
                            self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#FFFFFF"))
                            return
                        }
                        
                        print("가장 가까운 예약된 술 약속 ID:", nearestAppointmentId)
                        
                        // 예약된 술 약속 상태 확인
                        self.checkAppointmentStatus(appointmentId: nearestAppointmentId)
                    }
                }
            }
        }
    }
    
    // 위치 매니저 설정
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation() // 위치 업데이트 시작
        } else {
            print("위치 서비스가 비활성화되어 있습니다.")
        }
    }
    
    // 위치 정보 사용 동의 여부
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("위치 접근이 허용되었습니다.")
            locationManager.startUpdatingLocation()
        case .denied:
            print("위치 접근이 거부되었습니다. 설정에서 변경해야 합니다.")
        case .restricted:
            print("위치 접근이 제한되었습니다.")
        case .notDetermined:
            print("위치 접근 상태가 결정되지 않았습니다.")
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    // CLLocationManagerDelegate - 위치 업데이트 시 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentLatitude = location.coordinate.latitude
        currentLongitude = location.coordinate.longitude
        
        print("현재 위치 - 위도: \(currentLatitude ?? 0), 경도: \(currentLongitude ?? 0)")
        
        // 위치 업데이트 중지 (필요 시 한 번만 가져오기)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 정보를 가져오지 못했습니다: \(error.localizedDescription)")
    }
}


//MARK: GET Puppy Character Info
extension HomeViewController {
    
    func getPupptInfo() async {
        do {
            if let puppyInfo = try await PuppyInfoService.fetchPuppyInfo()?.result {
                DispatchQueue.main.async {
                    self.homeView.configurePuppyInfo(to: puppyInfo)
                }
            } else {
                print("Puppy Info is nil...")
            }
        } catch {
            print("Failed to fetch puppy info \(error)")
        }
    }
    
}

//MARK: Add Button Actions
extension HomeViewController {
    private func defineButtonActions() {
        self.homeView.decorationButton.addTarget(self, action: #selector(decorationButtonPressed), for: .touchUpInside)
        self.homeView.rompingButton.addTarget(self, action: #selector(rompingButtonPressed), for: .touchUpInside)
        self.homeView.collectionButton.addTarget(self, action: #selector(collectionPressed), for: .touchUpInside)
        self.homeView.puppyImageButton.addTarget(self, action: #selector(puppyImagePressed), for: .touchUpInside)
        self.homeView.drinkingCapacityButton.addTarget(self, action: #selector(drinkingCapacityButtonPressed), for: .touchUpInside)
        self.homeView.addDrinkingHistoryButton.addTarget(self, action: #selector(addDrinkingHistoryButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func decorationButtonPressed() {
        let decoVC = DecoViewController()
        decoVC.hidesBottomBarWhenPushed = true  // 탭바 숨기기 설정
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(decoVC, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: decoVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    // 놀아주기 버튼 클릭시
    @objc
    private func rompingButtonPressed() {
        print("Romping Button Pressed")
        // 서버 연동
        rompingToServer()
        
        // 강아지 애니메이션 효과
        showDogAnimation(animationType: "PLAYING")
        
        // 포인트 휙득 알림 표시 (10P)
        showPointAlert()
        
        // 버튼 비활성화 & 타이머 시작
        startCooldown()
        
    }
    
    @objc
    private func collectionPressed() {
        let collectionVC = CollectionViewController()
        collectionVC.hidesBottomBarWhenPushed = true
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(collectionVC, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: collectionVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    @objc
    private func puppyImagePressed() {
        print("Puppy Image Button Pressed")
    }
    
    // 주량 확인 페이지 이동 함수
    @objc private func drinkingCapacityButtonPressed() {
        print("Drinking Capacity Button Pressed")
        
        let drinkingInfoVC = DrinkingInfoViewController()
        drinkingInfoVC.hidesBottomBarWhenPushed = true  // 탭 바 숨기기 설정
        
        // 네비게이션 컨트롤러를 통해 화면 전환
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drinkingInfoVC, animated: true)
        } else {
            // 네비게이션 컨트롤러가 없으면 새로 생성하여 표시
            let navController = UINavigationController(rootViewController: drinkingInfoVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    @objc
    private func addDrinkingHistoryButtonPressed() {
        print("Add Drinking History Button Pressed")
        
        // 버튼의 title을 확인
        let buttonTitle = homeView.addDrinkingHistoryButton.getTitleLabel()
        
        if buttonTitle == "음주 기록" {
            // 음주 기록 화면으로 이동
            let hangoverVC = HangoverViewController()
            self.navigationController?.isNavigationBarHidden = true
            hangoverVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(hangoverVC, animated: true)
            
        } else if buttonTitle == "술 마시는 중" {
            // 음주 중 화면으로 이동
            guard let appointmentId = ongoingAppointmentId else {
                print("appointmentId가 없습니다.")
                return
            }
            
            let drinkingVC = DrinkingViewController(appointmentId: appointmentId)
            self.navigationController?.isNavigationBarHidden = true
            drinkingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(drinkingVC, animated: true)
            
        } else {
            print("알 수 없는 버튼 상태입니다.")
        }
    }
}

// 놀아주기 버튼에 대한 함수
extension HomeViewController {
    
    // 서버 연동
    private func rompingToServer() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.accessToken.rawValue)!)"
        ]
        
        AF.request(K.String.puppymodeLink + "/puppies/play",
                   method: .post,
                   headers: headers)
        .responseDecodable(of: PuppyPlayResponse.self) { [weak self] response in
            
            guard let self = self else { return }
            
            switch response.result {
            case .success(let puppyResponse) :
                if puppyResponse.isSuccess {
                    print("놀아주기 서버 연동 성공")
                    print("성공")
                    Task {
                        await self.getPupptInfo()
                    }
                } else {
                    print("Puppy Play API Error: \(puppyResponse.message)")
                }
            case .failure(let error) :
                print("Network Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    @objc private func showDogAnimation(animationType: String) {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.accessToken.rawValue)!)"
        ]
        
        let parameter =  PuppyAnimationParameter(animationType: animationType)
        
        AF.request(K.String.puppymodeLink + "/puppies/animations/frames",
                   method: .get,
                   parameters: parameter,
                   headers: headers)
        .responseDecodable(of: PuppyAnimationResponse.self) { [weak self] response in
            
            guard let self = self else { return }
            
            switch response.result {
            case .success(let response) :
                if response.isSuccess {
                    print("애니메이션 프레임 조회 성공")
                    
                    let animationImages = response.result.imageUrls
                    self.startAnimation(animationImages: animationImages) // 애니메이션 시작
                    
                } else {
                    print("애니메이션 프레임 조회 API Error: \(response.message)")
                }
            case .failure(let error) :
                print("애니메이션 프레임 조회 Network Error: \(error.localizedDescription)")
            }
        }

    }
    
    @objc private func startAnimation(animationImages: [String] = []) {
        guard !animationImages.isEmpty else { return }
        
        var index = 0
        var repeatCount = 0
        var maxRepeatCount = 2
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            self.homeView.puppyImageButton.setImageFromURL(animationImages[index]) // 공통 함수 사용
            index = (index + 1) % animationImages.count
            
            repeatCount += 1
            if repeatCount >= maxRepeatCount * 2 { // (두 개의 이미지를 번갈아 바꾸므로 *2)
                timer.invalidate() // 애니메이션 종료
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // self.getPupptInfo()
                }
            }
        }
    }
       
    
    private func showPointAlert() {
        // 알림 버튼 위치 설정
        self.view.addSubview(coinAlermButton)
        coinAlermButton.coinLabel.text = "10P 획득 !"
        
        coinAlermButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(59)
        }
        
        // 알림 버튼 1초 후에 사라지게 설정
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.coinAlermButton.removeFromSuperview()
        }
    }
    
    private func startCooldown() {
        homeView.rompingButton.isEnabled = false
        homeView.rompingButton.alpha = 0.5
        homeView.countdownLabel.alpha = 1
        homeView.countdownLabel.text = "23:59:59"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            let hours = remainingTime / 3600
            let minutes = (remainingTime % 3600) / 60
            let seconds = remainingTime % 60
            
            // 시간이 0일 경우 분:초만 표시
            if hours > 0 {
                homeView.countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                homeView.countdownLabel.font = UIFont(name: "NotoSansKR-Bold", size: 12)!

            } else {
                homeView.countdownLabel.text = String(format: "%02d:%02d", minutes, seconds)
                homeView.countdownLabel.font = UIFont(name: "NotoSansKR-Bold", size: 14)!
            }
        } else {
            resetButton()
        }
    }
    
    // 30분 후 버튼 활성화
    private func resetButton() {
        timer?.invalidate()
        timer = nil
        
        homeView.countdownLabel.alpha = 0
        homeView.rompingButton.isEnabled = true
        homeView.rompingButton.alpha = 1
        
    }
    
    @objc private func handleFeedNotification(_ notification: Notification) {
        guard let animationType = notification.userInfo?["animationType"] as? String else {
            print("❌ animationType이 없습니다!")
            return
        }

        showDogAnimation(animationType: animationType) // 기존 함수 호출!
    }

}


// MARK: - 음주 중인지 아닌지 체크
extension HomeViewController {
    
    // GET /appointments API 호출 함수
    private func fetchAppointments(completion: @escaping ([SingleAppointment]) -> Void) {
        guard let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            print("인증 토큰을 가져올 수 없습니다.")
            completion([])
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        let url = "\(K.String.puppymodeLink)/appointments"
        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: GetAllAppointmentsResponse.self) { response in
            switch response.result {
            case .success(let data):
                if data.isSuccess, let appointments = data.result?.appointments {
                    completion(appointments)
                } else {
                    print("응답 성공이지만 약속 데이터가 없습니다.")
                    completion([])
                }
            case .failure(let error):
                print("API 요청 실패:", error.localizedDescription)
                completion([])
            }
        }
    }
    
    // 가장 가까운 SCHEDULED 상태의 약속  조회하기 API
    private func checkNearestScheduledAppointment(completion: @escaping (Int?) -> Void) {
        guard let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            print("인증 토큰을 가져올 수 없습니다.")
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        let url = "\(K.String.puppymodeLink)/appointments/nearest-scheduled"
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: NearestScheduledAppointmentResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if data.code == "APPOINTMENT_NEAREST_SCHEDULED_FOUND" {
                        print("가장 가까운 예약된 술 약속 조회 성공!")
                        completion(data.result?.appointmentId)
                    } else if data.code == "NO_SCHEDULED_APPOINTMENT_TODAY" {
                        print("오늘 날짜의 예약된 술 약속이 없습니다.")
                        completion(nil)
                    } else {
                        print("응답 코드가 예상치 못한 값입니다: \(data.code)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("API 요청 실패:", error.localizedDescription)
                    completion(nil)
                }
            }
    }
    
    // 음주 중 상태 조회하기 API --> ONGOING 시 버튼 기능 변경, 아닐 시 주량 기록으로 유지
    private func checkAppointmentStatus(appointmentId: Int) {
        guard let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            print("인증 토큰을 가져올 수 없습니다.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        let url = "\(K.String.puppymodeLink)/appointments/\(appointmentId)/status"
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: AppointmentStatusResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if data.code == "SUCCESS_GET_APPOINTMENT_STATUS" {
                        print("약속 상태 조회 성공:", data.result?.appointmentStatus ?? "상태 없음")
                        
                        if data.result?.appointmentStatus == "ONGOING" {
                            // ONGOING 상태인 경우
                            print("ONGOING 상태입니다.")
                            self.ongoingAppointmentId = appointmentId
                            DispatchQueue.main.async {
                                self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "술 마시는 중")
                                self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "...")
                                self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#C3E9DF"))
                            }
                        } else {
                            // ONGOING이 아닌 경우 startAppointment 호출
                            print("ONGOING 상태가 아닙니다.")
                            self.startAppointment(appointmentId: appointmentId)
                        }
                    } else {
                        print("응답 코드가 SUCCESS_GET_APPOINTMENT_STATUS가 아닙니다.")
                        DispatchQueue.main.async {
                            self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "음주 기록")
                            self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "어제 마셨어요")
                            self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#FFFFFF"))
                            
                        }
                    }
                case .failure(let error):
                    print("API 요청 실패:", error.localizedDescription)
                }
            }
    }
    
    // 술 약속 시작하기 API --> 시작 성공 시 버튼 기능 변경, 시작 실패 시 주량 기록으로 유지
    private func startAppointment(appointmentId: Int) {
        guard let latitude = currentLatitude, let longitude = currentLongitude else {
            print("위치 정보를 가져올 수 없습니다.")
            return
        }
        
        let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) ?? ""
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters: [String: Any] = [
            "latitude": Double(String(format: "%.6f", latitude)) ?? 0.0,
            "longitude": Double(String(format: "%.6f", longitude)) ?? 0.0
        ]
        
        print("appointmentId: ", appointmentId)
        
        let url = "\(K.String.puppymodeLink)/appointments/\(appointmentId)/start"
        
        print("위도 경도 parameters : ", parameters)
        print("api url:", url)
        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .response { response in
            print("응답 상태 코드:", response.response?.statusCode ?? "상태 코드를 가져올 수 없습니다.")
            if let data = response.data, !data.isEmpty {
                do {
                    let decodedResponse = try JSONDecoder().decode(StartAppointmentResponse.self, from: data)
                    DispatchQueue.main.async {
                        if decodedResponse.code == "SUCCESS_START_DRINKING_APPOINTMENT" {
                            print("술 약속 시작 성공!")
                            self.sendNotificationForAppointment() // 술 약속 시작 푸시 알림
                            self.ongoingAppointmentId = appointmentId
                            
                            self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "술 마시는 중")
                            self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "...")
                            self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#C3E9DF"))
                        } else {
                            print("응답 코드가 SUCCESS_START_DRINKING_APPOINTMENT가 아닙니다.")
                            self.homeView.addDrinkingHistoryButton.setTitleLabel(to: "음주 기록")
                            self.homeView.addDrinkingHistoryButton.setSubTitleLabel(to: "어제 마셨어요")
                            self.homeView.addDrinkingHistoryButton.setBackgroundColor(to: UIColor(hex: "#FFFFFF"))
                        }
                    }
                } catch {
                    print("디코딩 실패:", error.localizedDescription)
                }
            } else {
                print("서버로부터 빈 응답을 받았습니다.")
            }
        }
    }
    
    
    private func sendNotificationForAppointment() {
        guard let authToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            print("인증 토큰을 가져올 수 없습니다.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(authToken)"
        ]
        
        let url = "\(K.String.puppymodeLink)/fcm/notifications/appointments"
        
        AF.request(url,
                   method: .post,
                   headers: headers)
        .response { response in
            print("FCM 알림 응답 상태 코드:", response.response?.statusCode ?? "상태 코드를 가져올 수 없습니다.")
            
            if let data = response.data, !data.isEmpty {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("FCM 알림 응답 데이터:", jsonResponse)
                    }
                } catch {
                    print("FCM 응답 디코딩 실패:", error.localizedDescription)
                }
            } else {
                print("FCM 서버로부터 빈 응답을 받았습니다.")
            }
        }
    }
}

import SwiftUI
#Preview {
    HomeViewController()
}
