//
//  AppleSocialLoginService.swift
//  PuppyMode
//
//  Created by 이승준 on 1/27/25.
//

import AuthenticationServices
import Alamofire

class AppleLoginService {
    
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
