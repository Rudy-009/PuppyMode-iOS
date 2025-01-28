//
//  LoginResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Foundation

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LoginResult
}

struct LoginResult: Codable {
    let jwt: String
    let userInfo: UserInfo
}

struct UserInfo: Codable {
    let userId: Int
    let username: String
    let email: String
}
