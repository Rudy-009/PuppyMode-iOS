//
//  NotificationCenter.swift
//  PuppyMode
//
//  Created by 이승준 on 1/29/25.
//

import Alamofire

class NotificationService {
    
    static func sendNotification(body: NotificationContent) {
        
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
            print("JWT Token Not Found in Keychain Service")
            return
        }
        
        guard let fcm = KeychainService.get(key: FCMTokenKey.fcm.rawValue) else {
            print("FCM Token Not Found in Keychain Service")
            return
        }
        
        let parameters = NotificationPostBody(
            token: fcm ,
            title: body.title,
            body: body.body,
            image: nil
        )
        

        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(jwt)",
            "Content-Type": "application/json"
        ]
        
        let request = AF.request(
            K.String.puppymodeLink + "/fcm/notifications/",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        
        // curl 명령어 출력
        debugPrint(request)
        
        request.responseDecodable(of: NotificationPostResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("Response: \(response)")
            case .failure(let error):
                print("Error: \(error)")
                debugPrint(response)
            }
        }
    }
    
}
