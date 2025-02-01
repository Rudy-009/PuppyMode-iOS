//
//  API Keys.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import Foundation

enum UserInfoKey: String {
    case jwt, userId, username, email
}

enum KakaoAPIKey: String {
    case kakaoAccessToken
    case kakaoRefreshToken
    case kakaoUserID = "KakaoUserID"
    case kakaoAppKey = "KAKAO_APP_KEY"
}

enum AppleAPIKey: String {
    case appleUserID = "AppleUserID"
}

enum FCMTokenKey : String {
    case fcm = "FCMToken"
}
