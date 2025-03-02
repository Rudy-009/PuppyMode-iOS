//
//  PuppyInfoService.swift
//  PuppyMode
//
//  Created by 이승준 on 2/19/25.
//

import Alamofire

class PuppyInfoService {
    
    @MainActor
    static func fetchPuppyInfo() async throws -> PuppyInfoResponse? {
        guard let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue) else { return nil }
        
        return try await AF.request( K.String.puppymodeLink + "/puppies",
                    headers: [
                        "accept": "*/*",
                        "Authorization": "Bearer " + accessToken
                    ])
        .serializingDecodable(PuppyInfoResponse.self)
        .value
    }
    
}
