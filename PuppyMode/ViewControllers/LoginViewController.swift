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
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // AppleUserID KeyChain에 저장
            _ = KeychainService.add(key: AppleAPIKey.appleUserID.rawValue, value: appleIDCredential.user)
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let fullName = appleIDCredential.fullName {
                print("authorizationCode \(String(data: authorizationCode, encoding: .utf8))")
                print("identityToken \(String(data: identityToken, encoding: .utf8))")
                let givenName = fullName.givenName ?? "No given name"
                let familyName = fullName.familyName ?? "No family name"
            }
            
        default:
            print("")
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
