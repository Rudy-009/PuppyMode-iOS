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
                if KeychainService.add(key: K.String.kakaoUserID, value: "\(kakaoUserId)") {
                    print("kakaoUserId \(kakaoUserId)")
                }
            }
        }
    }
    
    static func fetchKakaoUserInfo(with accessToken: String) {
        AF.request(K.String.puppymodeLink + "/auth/kakao/login",
                   method: .get,
                   parameters: ["accessToken": accessToken],
                   headers: ["accept": "*/*"])
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                if UserInfoService.addUserInfo(userInfo: loginResponse.result) {
                    print("jwt: \(loginResponse.result.jwt)")
                    print("UserInfo save succeed")
                }
                RootViewControllerService.toBaseViewController()
            case .failure(let error):
                print("Error LoginResponse \(K.String.puppymodeLink)/auth/kakao/login: \(error)")
            }
        }
    }
    
}
