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
    
    static func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                self.saveKakaoUserID()
                if let accessToekn = oauthToken?.accessToken {
                    self.fetchKakaoUserInfo(with: accessToekn)
                }
            }
        }
    }
    
    static func saveKakaoUserID() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                guard let kakaoUserId = user?.id else { return }
                if KeychainService.add(key: KakaoAPIKey.kakaoUserID.rawValue, value: "\(kakaoUserId)") {
                    print("kakaoUserId \(kakaoUserId)")
                }
            }
        }
    }
    
    static func fetchKakaoUserInfo(with accessToken: String) {
        let fcm = KeychainService.get(key: FCMTokenKey.fcm.rawValue) ?? "none"
        
        AF.request(K.String.puppymodeLink + "/auth/kakao/login",
                   method: .get,
                   parameters: ["accessToken": accessToken,
                                "FCMToken": fcm],
                   headers: ["accept": "*/*"])
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                if UserInfoService.addUserInfoToKeychainService(userInfo: loginResponse.result) {
                    if let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue ) {
                        print("JWT: \(jwt)")
                        print("Access Token: \(accessToken)")
                    }
                    if loginResponse.result.userInfo.isNewUser {
                        RootViewControllerService.toPuppySelectionViewController()
                    } else {
                        RootViewControllerService.toBaseViewController()
                    }
                }
            case .failure(let error):
                print("Error LoginResponse \(K.String.puppymodeLink)/auth/kakao/login: \(error)")
            }
        }
    }
    
}
