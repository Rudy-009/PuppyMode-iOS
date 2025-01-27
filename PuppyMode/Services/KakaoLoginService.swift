//
//  KakaoLoginManager.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKTalk
import KakaoSDKFriendCore
import Alamofire
import UIKit

class KakaoLoginService {
    
    static func kakaoLoginWithAccount() async {
        do {
            let oauthToken = try await UserApi.shared.loginWithKakaoAccountAsync()
            // try await saveKakaoUserID()
            try await fetchKakaoUserInfo(with: oauthToken.accessToken)
        } catch {
            print("Kakao login error: \(error)")
        }
    }
    
    static func fetchKakaoUserInfo(with accessToken: String) async throws {
        let url = K.String.puppymodeLink + "/auth/kakao/login"
        let headers: HTTPHeaders = ["accept": "*/*"]
        let parameters: Parameters = ["accessToken": accessToken]
        
        let response = try await AF.request(url,
                                            method: .get,
                                            parameters: parameters,
                                            headers: headers)
            .serializingDecodable(LoginResponse.self)
            .value
        
        if UserInfoService.addUserInfo(userInfo: response.result) {
            print("UserInfo save succeed")
        }
        
        RootViewControllerService.toBaseViewController()
        
//        if true {
//            RootViewControllerService.toPuppySelectionViewController()
//        } else {
//            RootViewControllerService.toBaseViewController()
//        }
        
    }
            
    static func saveKakaoUserID() async throws {
        let user = try await UserApi.shared.meAsync()
        guard let kakaoUserId = user.id else { return }
        
        if KeychainService.add(key: K.String.kakaoUserID, value: "\(kakaoUserId)") {
            print("Kakao user ID saved successfully")
        }
    }
    
    static func KakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡 앱으로 로그인 인증
            kakaoLonginWithApp()
        } else {
            Task {
                await kakaoLoginWithAccount()
            }
        }
    }
    
    static func kakaoLonginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                Task {
                    try await self.saveKakaoUserID()
                }
            }
        }
    }

}
