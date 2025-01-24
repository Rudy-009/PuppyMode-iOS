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
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        connectButtonActions()
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
    
    // 인증창을 보여주기 위한 메서드 (인증창을 보여 줄 화면을 설정)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window ?? UIWindow()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
        // Apple 계정으로 로그인 성공
            // printAppleIDCredential(appleIDCredential: appleIDCredential) // appleIDCredential의 내용을 출력해보기
            
            // UserID를 KeyChain에 저장
            if KeychainService.add(key: "UserID", value: appleIDCredential.user) {}
            
            // User의 정보를 서버에 전송
            
            // BaseViewController 화면 으로 이동
            changeRootViewController()
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
                        
            print("username: \(username)")
            print("password: \(password)")
        default:
            break
        }
    }
    
    // 로그인 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("로그인 실패", error.localizedDescription)
    }
    
    // 로그인 성공 시, BaseViewController로 SceneDelegate의 rootView를 변경
    func changeRootViewController() {
        let baseViewController = BaseViewController()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(baseViewController, animated: false)
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
}

//MARK: Kakao Social Login

extension LoginViewController {
    @objc
    private func popUpKakaoLoginView() {
        print("Kakao Login Tapped")
    }
}

//MARK: Connect Button Actions
extension LoginViewController {
    private func connectButtonActions() {
        loginView.appleLoginButton.addTarget(self, action: #selector(popUpAppleLoginView), for: .touchUpInside)
        loginView.kakaoLoginButton.addTarget(self, action: #selector(popUpKakaoLoginView), for: .touchUpInside)
    }
}

