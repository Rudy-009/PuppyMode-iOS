//
//  RevokeViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit
import KakaoSDKUser
import Alamofire

class RevokeViewController: UIViewController {
    
    private lazy var revokeView = RevokeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = revokeView
        defineButtonActions()
    }
    
}

extension RevokeViewController {
    
    private func defineButtonActions() {
        revokeView.popButton.addTarget(self, action: #selector(popButtonPressed), for: .touchUpInside)
        revokeView.revokeButton.addTarget(self, action: #selector(revokeButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func popButtonPressed() {
        print("Pop Button Pressed")
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Revoke Account
extension RevokeViewController {
    
    @objc
    private func revokeButtonPressed() {
        print("Revoke Button Pressed")
        
        let kakaoAccessToken = KeychainService.get(key:  KakaoAPIKey.kakaoAccessToken.rawValue ) ?? "none"
        let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue)
        
        AF.request(K.String.puppymodeLink + "/withdraw",
                   method: .delete,
                   parameters: ["accessToken": kakaoAccessToken],
                   headers: ["accept": "*/*",
                             "Authorization": "Bearer \(accessToken!)"]).responseDecodable(of: RevokeResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("success: \(response)")
            case .failure(let error):
                print(error)
            }
            
        }
        
        _ = UserInfoService.deleteAllKeys()
        self.kakaoRevoke()
        RootViewControllerService.toLoginViewController()
    }
    
    public func setPuppyInfo(puppy: PuppyInfoResult) {
        self.revokeView.configure(puppy: puppy)
    }
        
    private func kakaoRevoke() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            } else {
                print("unlink() success.")
            }
        }
    }
    
    private func appleRevoke() {
        // Apple 서버에서 탈퇴하기
    }
}
