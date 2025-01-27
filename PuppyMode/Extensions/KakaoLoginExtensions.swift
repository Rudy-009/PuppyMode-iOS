//
//  KakaoLoginExtensions.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth

extension UserApi {
    func loginWithKakaoAccountAsync() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            loginWithKakaoAccount { token, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = token {
                    continuation.resume(returning: token)
                }
            }
        }
    }
    
    func meAsync() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            me { user, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let user = user {
                    continuation.resume(returning: user)
                }
            }
        }
    }
}
