//
//  UserInfoModel.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Alamofire

class UserInfoService {
    
    static func addUserInfoToKeychainService(userInfo: LoginResult) -> Bool {

        return KeychainService.add(key: UserInfoKey.jwt.rawValue, value: userInfo.jwt) &&
        KeychainService.add(key: UserInfoKey.userId.rawValue, value: String(userInfo.userInfo.userId)) &&
        KeychainService.add(key: UserInfoKey.username.rawValue, value: userInfo.userInfo.username) &&
        KeychainService.add(key: UserInfoKey.email.rawValue, value: userInfo.userInfo.email)
    }
    
    static func deleteAllUserInfoFromKeychainService() -> Bool {
        return KeychainService.delete(key: UserInfoKey.jwt.rawValue) &&
        KeychainService.delete(key: UserInfoKey.userId.rawValue) &&
        KeychainService.delete(key: UserInfoKey.username.rawValue) &&
        KeychainService.delete(key: UserInfoKey.email.rawValue)
    }

    @MainActor
    static func getUserInfo() async throws -> UserInfoResponse? {
        guard let fcm = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
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
