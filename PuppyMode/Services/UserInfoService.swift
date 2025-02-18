//
//  UserInfoModel.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Alamofire

class UserInfoService {
    
    static func addUserInfoToKeychainService(userInfo: LoginResult) -> Bool {
        return  KeychainService.add(key: UserInfoKey.accessToken.rawValue, value: userInfo.accessToken) &&
                KeychainService.add(key: UserInfoKey.username.rawValue, value: userInfo.userInfo.username)
    }
    
    static func deleteAllUserInfoFromKeychainService() -> Bool {
        return  KeychainService.delete(key: UserInfoKey.accessToken.rawValue) &&
                KeychainService.delete(key: UserInfoKey.username.rawValue)
    }
    
    static func deleteAllKeys() -> Bool {
        return  UserInfoService.deleteAllUserInfoFromKeychainService() &&
                KakaoLoginService.deleteAllKakaoToken()
    }
    
    @MainActor
    static func getUserInfo() async throws -> UserInfoResponse? {
        guard let fcm = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else {
            return nil
        }
        
        return try await AF.request(K.String.puppymodeLink + "/users",
                                  headers: [
                                      "accept": "*/*",
                                      "Authorization": "Bearer " + fcm
                                  ])
        .serializingDecodable(UserInfoResponse.self)
        .value
    }

}
