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
    let result: KakaoLoginResult
}

struct KakaoLoginResult: Codable {
    let accessToken: String
    let refreshToken: String
    let userInfo: KakaoUserInfo
}

struct KakaoUserInfo: Codable {
    let username: String
    let isNewUser: Bool
}

//{
//  "isSuccess": true,
//  "code": "string",
//  "message": "string",
//  "result": {
//    "accessToken": "string",
//    "refreshToken": "string",
//    "userInfo": {
//      "username": "string",
//      "isNewUser": true
//    }
//  }
//}

struct RevokeResponse: Codable {
    let isSuccess: Bool
    let code: String?
    let message: String?
    let result: String?
}
