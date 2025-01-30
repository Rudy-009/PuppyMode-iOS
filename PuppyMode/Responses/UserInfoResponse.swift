//
//  UserInfoResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 1/30/25.
//

import Foundation


struct UserInfoResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfoResult?
}

struct UserInfoResult: Codable {
    let userId: Int?
    let username: String?
    let email: String?
    let puppy: UserPuppy?
}

struct UserPuppy: Codable {
    let puppyId: Int?
    let puppyName: String?
}
