//
//  EndDrinkingViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/31/25.
//

import UIKit
import Alamofire

class EndDrinkingViewController: UIViewController {

    private let endDrinkingView = EndDrinkingView()

    private var currentIndex = 0
    private var animationTimer: Timer?
    private var currentFrameIndex = 0
    
    override func loadView() {
        self.view = endDrinkingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        endDrinkingView.okayButton.addTarget(self, action: #selector(didTapOkayButton), for: .touchUpInside)
        
        // 강아지 애니메이션
        fetchAnimationFrames(animationType: "PLAYING")
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
        titleLabel.text = "음주 종료"
        titleLabel.textColor = UIColor(hex: "#3C3C3C")
        titleLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .center
        navigationBar.addSubview(titleLabel)
        
        // Add constraints for the title label using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(navigationBar) // 네비게이션 바의 중앙에 위치
        }
    }
    
    // MARK: - Actions
    @objc private func didTapOkayButton() {
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([HomeViewController()], animated: true)
        }
    }
    
    // 애니메이션 프레임 가져오기
        private func fetchAnimationFrames(animationType: String) {
            let headers: HTTPHeaders = [
                "accept": "*/*",
                "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.accessToken.rawValue)!)"
            ]
            
            let parameter = PuppyAnimationParameter(animationType: animationType)
            
            AF.request(K.String.puppymodeLink + "/puppies/animations/frames",
                       method: .get,
                       parameters: parameter,
                       headers: headers)
                .responseDecodable(of: PuppyAnimationResponse.self) { [weak self] response in
                    guard let self = self else { return }
                    
                    switch response.result {
                    case .success(let response):
                        if response.isSuccess {
                            print("애니메이션 프레임 조회 성공")
                            let animationImages = response.result.imageUrls
                            self.startDogAnimation(with: animationImages) // 애니메이션 시작
                        } else {
                            print("애니메이션 프레임 조회 API Error: \(response.message)")
                        }
                    case .failure(let error):
                        print("애니메이션 프레임 조회 Network Error: \(error.localizedDescription)")
                    }
                }
        }
        
        // 애니메이션 시작
        private func startDogAnimation(with imageUrls: [String]) {
            guard !imageUrls.isEmpty else { return }
            
            // 타이머를 사용하여 주기적으로 이미지를 변경
            animationTimer?.invalidate() // 기존 타이머가 있다면 무효화
            currentFrameIndex = 0 // 초기화
            
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                // 현재 인덱스의 이미지 URL 가져오기
                let imageUrl = imageUrls[self.currentFrameIndex]
                
                // 이미지 로드 및 업데이트
                self.loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        self.endDrinkingView.dogImageView.image = image
                    }
                }
                
                // 다음 프레임으로 이동 (순환)
                self.currentFrameIndex = (self.currentFrameIndex + 1) % imageUrls.count
            }
        }
        
        // 이미지 로드 메서드
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
        
        deinit {
            animationTimer?.invalidate() // 타이머 해제
        }
}
