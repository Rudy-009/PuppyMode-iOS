//
//  LoginViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/10/25.
//

import UIKit
import AuthenticationServices
import Alamofire

class LoginViewController: UIViewController {
    
    private lazy var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        connectButtonActions()
    }
    
    // 로그인 성공 시, BaseViewController로 SceneDelegate의 rootView를 변경
    func changeRootToBaseViewController() {
        let baseViewController = BaseViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
    }
    
    // 회원가입 성공 시, PuppySelectionViewController로 변경
    func changeRootToPuppySelectionViewController() {
        let baseViewController = PuppySelectionViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
    }
}

//MARK: Kakao Social Login
extension LoginViewController {
    @objc
    private func showKakaoLoginView() {
        KakaoLoginService.kakaoLoginWithAccount()
    }
}

//MARK: Apple Social Login
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @objc
    private func popUpAppleLoginView() {
        print("Apple Login Tapped")
        
        let provider = ASAuthorizationAppleIDProvider()
        let requset = provider.createRequest()
        
        // 사용자에게 제공받을 정보를 선택 (이름 및 이메일)
        requset.requestedScopes = [.fullName, .email, ] // fullName, email, user, identityToken, authorizationCode
        
        let controller = ASAuthorizationController(authorizationRequests: [requset])
        controller.delegate = self                                                   // 로그인 정보 관련 대리자 설정
        controller.presentationContextProvider = self                                // 인증창을 보여주기 위해 대리자 설정
        controller.performRequests() // 로그인창 띄우기
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // AppleUserID KeyChain에 저장
            // _ = KeychainService.add(key: AppleAPIKey.appleUserID.rawValue, value: appleIDCredential.user)
            
            guard
                let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identityTokenString = String(data: identityToken, encoding: .utf8),
                let fcm = KeychainService.get(key: FCMTokenKey.fcm.rawValue)
            else { return }
            
            let fullName = appleIDCredential.fullName
            let familyName = fullName?.familyName ?? ""
            let givenName = fullName?.givenName ?? ""
            let username = "\(familyName)\(givenName)"
            
            print("authorizationCode \(authCodeString)")
            print("identityToken \(identityTokenString)")
            
            let parameters: [String: Any] = [
                "authorizationCode": authCodeString,
                "identityToken": identityTokenString,
                "user": [
                    "name": [
                        "firstName": familyName,
                        "lastName": givenName
                    ]
                ],
                "fcmToken": fcm,
                "username": username
            ]
            
            AF.request(
                K.String.puppymodeLink + "/auth/apple/login",
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: ["accept": "*/*"]
            )
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    if UserInfoService.addUserInfoToKeychainService(userInfo: loginResponse.result) {
                        if let accessToken = KeychainService.get(key: UserInfoKey.accessToken.rawValue ) {
                            print("AccessToken: \(accessToken)")
                        }
                        //                        if loginResponse.result.userInfo.isNewUser {
                        //                            RootViewControllerService.toPuppySelectionViewController()
                        //                        } else {
                        //                            RootViewControllerService.toBaseViewController()
                        //                        }
                    }
                case .failure(let error):
                    print("Error LoginResponse \(K.String.puppymodeLink)/auth/kakao/login: \(error)")
                }
            }
            
        case let passwordCredential as ASPasswordCredential:
            // iCloud Keychain credential. (AppleID & Password)
            break
        default:
            break
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor { // 로그인 창 띄우기
        self.view.window ?? UIWindow()
    }
}

//MARK: Connect Button Actions
extension LoginViewController {
    private func connectButtonActions() {
        loginView.appleLoginButton.addTarget(self, action: #selector(popUpAppleLoginView), for: .touchUpInside)
        loginView.kakaoLoginButton.addTarget(self, action: #selector(showKakaoLoginView), for: .touchUpInside)
    }
}
