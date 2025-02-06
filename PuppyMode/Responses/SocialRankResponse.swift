//
//  SocialAllRankResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 2/4/25.
//

import Foundation

struct SocialRankResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SocialRankUserResponse
}

struct SocialRankUserResponse: Codable {
    let currentUserRank: RankUserInfo
    let rankings: [RankUserInfo]
    let totalCount: Int
}

struct RankUserInfo: Codable {
    let rank : Int
    let username: String
    let puppyName: String?
    let level: Int
    let levelName: String
    let imageUrl: URL?
}

struct SocialFriendResponse {
    
}
