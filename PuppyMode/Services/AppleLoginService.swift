//
//  AppleSocialLoginService.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import AuthenticationServices
import Alamofire

class AppleLoginService {
    
    static func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // AppleUserID KeyChain에 저장
            _ = KeychainService.add(key: AppleAPIKey.appleUserID.rawValue, value: appleIDCredential.user)
            
            let authorizationCode = appleIDCredential.authorizationCode
            let identityToken = appleIDCredential.identityToken
            let fullName = appleIDCredential.fullName
            guard let fcm = KeychainService.get(key: FCMTokenKey.fcm.rawValue ) else { return }
            
            print("authorizationCode: \(String(describing: authorizationCode))")
            print("identityToken: \(String(describing: identityToken))")
            print("fullName: \(String(describing: fullName)))")
            
            
//            AF.request(K.String.puppymodeLink + "/auth/apple/login",
//                       method: .get,
//                       parameters: ["authorizationCode": authorizationCode,
//                                    "identityToken": identityToken,
//                                    "user": [
//                                        "name" : [
//                                            "firstName": fullName?.familyName,
//                                            "lastName": fullName?.givenName
//                                                 ]
//                                            ],
//                                    "fcmToken": fcm,
//                                    "username": (fullName?.familyName)! + (fullName?.givenName)!],
//                       headers: ["accept": "*/*"])
//            .responseDecodable(of: LoginResponse.self) { response in
//                switch response.result {
//                case .success(let loginResponse):
//                    if UserInfoService.addUserInfoToKeychainService(userInfo: loginResponse.result) {
//                        if let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue ) {
//                            print("AccessToken: \(accessToken)")
//                        }
//                        if loginResponse.result.userInfo.isNewUser {
//                            RootViewControllerService.toPuppySelectionViewController()
//                        } else {
//                            RootViewControllerService.toBaseViewController()
//                        }
//                    }
//                case .failure(let error):
//                    print("Error LoginResponse \(K.String.puppymodeLink)/auth/kakao/login: \(error)")
//                }
//            }
            
        case let passwordCredential as ASPasswordCredential:
            // iCloud Keychain credential. (AppleID & Password)
            break
        default:
            break
        }
    }
    
    // 로그인 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("Apple Login Failed", error.localizedDescription)
    }
    
    // 로그인 성공시 appleIDCredential의 내용을 출력해보는 함수
    func printAppleIDCredential(appleIDCredential: ASAuthorizationAppleIDCredential) {
        // fullName과 email 같은 경우는 개인정보이다 보니, 처음 로그인 하는 경우에만 제공되며 두 번째부터는 제공이 되지 않는다.
        
        // user: 처음 로그인을 하게 되면, 유저에게 주어지는 고유 식별
        // identityToken: 사용자에 대한 정보를 앱에 안전히 전달하는 JWT
        // authorizationCode: 앱이 서버와 상호 작용하는 데 사용하는 토큰
        
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        print("useridentifier: \(userIdentifier)")
        print("fullName: \(String(describing: fullName))")
        print("email: \(String(describing: email))")
        
        if  let authorizationCode = appleIDCredential.authorizationCode,
            let identityToken = appleIDCredential.identityToken,
            let authCodeString = String(data: authorizationCode, encoding: .utf8),
            let identifyTokenString = String(data: identityToken, encoding: .utf8) {
            print("authorizationCode: \(authorizationCode)")
            print("identityToken: \(identityToken)")
            print("authCodeString: \(authCodeString)")
            print("identifyTokenString: \(identifyTokenString)")
        }
    }
    
    private func checkUserCredentialState() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        if let appleUserID = KeychainService.get(key: AppleAPIKey.appleUserID.rawValue ) {
            appleIDProvider.getCredentialState(forUserID: appleUserID) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("authorized")
                case .revoked:
                    print("revoked")
                case .notFound:
                    print("notFound")
                case .transferred:
                    print("transferred")
                default:
                    break
                }
            }
            return
        }
    }
}
