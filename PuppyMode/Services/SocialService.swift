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
        guard !isFetchingGlobalRankData else { return }
        
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
                    return
                }
            case .failure(let error):
                print(error)
            }
            isFetchingGlobalRankData = false
        }
        
        DispatchQueue.main.async {
            completion?()
        }
    }
    
    static func fetchFriendRankData(completion: (() -> Void)? = nil) {
        guard !isFetchingFriendRankData else { print("Friend Data is fetching..."); return }
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue),
              let kakaoAccessToken = KeychainService.get(key: KakaoAPIKey.kakaoAccessToken.rawValue) else { return }
        
        isFetchingFriendRankData = true
        print("Friend Data fetching started...")
        
        AF.request(
            K.String.puppymodeLink + "/rankings/friends?accessToken=\(kakaoAccessToken)&page=\(friendRankPage)&size=\(pageSize)",
            method: .get,
            headers: ["accept": "*/*",
                      "Authorization": "Bearer \(jwt)"])
        .responseDecodable(of: SocialRankResponse.self) { response in
            defer {
                isFetchingFriendRankData = false
                DispatchQueue.main.async { completion?() } // 완료 핸들러 이동
            }
            
            switch response.result {
            case .success(let response):
                print("me among friends: \(response.result.currentUserRank)")
                print("friends: \(response.result.rankings)")
                
                RankModel.friendsRankData.append(contentsOf: response.result.rankings)
                
                if RankModel.myRankInFriends == nil {
                    RankModel.myRankInFriends = response.result.currentUserRank
                }
                
                friendRankPage += pageSize // 페이지 증가 로직 이동
                
            case .failure(let error):
                print("Friends error \(error)")
            }
        }
    }

    
}
