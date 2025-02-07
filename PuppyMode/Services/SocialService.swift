//
//  SocialService.swift
//  PuppyMode
//
//  Created by 이승준 on 2/4/25.
//

import Alamofire
import Foundation

class SocialService {
    
    static var isFetchingGlobalRankData: Bool = false
    static var isFetchingFriendRankData: Bool = false
    static var globalRankPage: Int = 0
    static var friendRankPage: Int = 0
    static let pageSize: Int = 10
    
    static func fetchGlobalRankData(completion: (() -> Void)? = nil) {
        guard !isFetchingGlobalRankData else { print("fetching global data"); return }
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else { return }
        
        isFetchingGlobalRankData = true
        AF.request(
            K.String.puppymodeLink + "/rankings/global?page=\(globalRankPage)&size=\(pageSize)",
            method: .get,
            headers: ["accept": "*/*",
                      "Authorization": "Bearer \(jwt)"])
        .responseDecodable(of: SocialRankResponse.self) { response in
            switch response.result {
            case .success(let response):
                RankModel.globalRankData.append(contentsOf: response.result.rankings)
                guard let _ = RankModel.myGlobalRank else {
                    RankModel.myGlobalRank = response.result.currentUserRank
                    globalRankPage += pageSize
                    isFetchingGlobalRankData = false
                    return
                }
            case .failure(let error):
                print(error)
            }
            // 인덱스 값 변화
            globalRankPage += pageSize
            isFetchingGlobalRankData = false
        }
        
        DispatchQueue.main.async {
            completion?()
        }
    }
    
    static func fetchFriendRankData(completion: (() -> Void)? = nil) {
        guard !isFetchingFriendRankData else { print("fetching friend data"); return }
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else { return }
        guard let kakaoAccessToken = KeychainService.get(key: KakaoAPIKey.kakaoAccessToken.rawValue) else { return }
        
        isFetchingFriendRankData = true
        AF.request(
            K.String.puppymodeLink + "/rankings/friends?accessToken=\(kakaoAccessToken)&page=\(friendRankPage)&size=\(pageSize)",
            method: .get,
            headers: ["accept": "*/*",
                      "Authorization": "Bearer \(jwt)"])
        .responseDecodable(of: SocialRankResponse.self) { response in
            switch response.result {
            case .success(let response):
                RankModel.friendsRankData.append(contentsOf: response.result.rankings)
                guard let _ = RankModel.myRankInFriends else {
                    RankModel.myRankInFriends = response.result.currentUserRank
                    friendRankPage += pageSize
                    isFetchingFriendRankData = false
                    return
                }
            case .failure(let error):
                print(error)
            }
            // 인덱스 값 변화
            friendRankPage += pageSize
            isFetchingFriendRankData = false
        }
        
        DispatchQueue.main.async {
            completion?()
        }
    }
    
}
