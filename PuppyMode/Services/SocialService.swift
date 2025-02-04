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
    static var globalRankPage: Int = 0
    static let pageSize: Int = 10
    
    static func fetchGlobalRankData(completion: (() -> Void)? = nil) {
        guard !isFetchingGlobalRankData else { print("fetching data");  return}
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else { return }
        
        isFetchingGlobalRankData = true
        AF.request(
            K.String.puppymodeLink + "/rankings/global?page=\(globalRankPage)&size=\(pageSize)",
            method: .get,
            headers: ["accept": "*/*",
                      "Authorization": "Bearer \(jwt)"])
        .responseDecodable(of: GlobalRankResponse.self) { response in
            switch response.result {
            case .success(let response):
                print(response.result)
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
    
    static func fetchFriendRankData() {
        
    }
    
}
