//
//  PuppyInfoResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 1/29/25.
//

import Foundation

struct PuppyInfoResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PuppyInfoResult
}

struct PuppyInfoResult: Codable {
    let puppyId: Int
    let puppyName: String?
    let level: Int
    let levelName: String
    let imageUrl: String?
    let levelMinExp: Int
    let levelMaxExp: Int
    let puppyExp: Int
}
