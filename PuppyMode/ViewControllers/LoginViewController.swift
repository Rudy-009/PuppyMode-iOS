//
//  LoginViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/10/25.
//

import UIKit
import AuthenticationServices
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

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
            if KeychainService.add(key: K.String.appleUserID, value: appleIDCredential.user) {}
            
            // User의 정보를 서버에 전송
            
            // BaseViewController 화면 으로 이동
            changeRootViewController()
            
        case let passwordCredential as ASPasswordCredential:
            // iCloud Keychain credential. (AppleID & Password)
            let _ = passwordCredential.user
            // let password = passwordCredential.password
            
            // print("apple username: \(username)")
            // print("apple password: \(password)")
        default:
            break
        }
    }
    
    // 로그인 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("Apple Login Failed", error.localizedDescription)
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
        kakaoLoginWithAccount()
    }
    
    func KakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡 앱으로 로그인 인증
            kakaoLonginWithApp()
        } else {
            kakaoLoginWithAccount()
        }
    }
    
    func kakaoLonginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                self.saveKakaoUserID()
                self.changeRootToBaseViewController()
            }
        }
    }
    
    func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                // 로그인 성공 token 발급
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                    }
                }
                
                
                if let accessToekn = oauthToken?.accessToken {
                    self.fetchKakaoUserInfo(with: accessToekn)
                    self.changeRootToBaseViewController()
                }
            }
        }
    }
    
    func saveKakaoUserID() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                guard let kakaoUserId = user?.id else { return }
                if KeychainService.add(key: K.String.kakaoUserID, value: "\(kakaoUserId)") {
                    
                }
            }
        }
    }
    
    func fetchKakaoUserInfo(with accessToken: String) {
        AF.request(K.String.puppymodeLink + "/auth/kakao/login",
                   method: .get,
                   parameters: ["accessToken": accessToken],
                   headers: ["accept": "*/*"])
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    if UserInfoModel.addUserInfo(userInfo: loginResponse.result) {
                        print("UserInfo save succeed")
                    }
                case .failure(let error):
                    print("Error LoginResponse \(K.String.puppymodeLink)/auth/kakao/login: \(error)")
                }
            }
    }
        
    func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                if let userName = user?.kakaoAccount?.name,
                    let userEmail = user?.kakaoAccount?.email,
                    let userProfile = user?.kakaoAccount?.profile?.profileImageUrl
                    {
                    print("이름: \(userName)")
                    print("이메일: \(userEmail)")
                    print("프로필: \(userProfile)")
                }
            }
        }
    }
}

//MARK: Kakao Login Communication
extension LoginViewController {
    
    func request(code: String) {
        let baseURL = "https://puppy-mode.site/auth/kakao/callback"
        let parameters: [String: String] = ["code": code]
        let headers: HTTPHeaders = [
            "accept": "*/*"
        ]

        AF.request(baseURL,
                  method: .get,
                  parameters: parameters,
                  headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        // JSON 응답을 처리하는 경우
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Response: \(json)")
                        }
                    } catch {
                        print("JSON 파싱 에러: \(error)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}

//MARK: Connect Button Actions
extension LoginViewController {
    private func connectButtonActions() {
        loginView.appleLoginButton.addTarget(self, action: #selector(popUpAppleLoginView), for: .touchUpInside)
        loginView.kakaoLoginButton.addTarget(self, action: #selector(popUpKakaoLoginView), for: .touchUpInside)
    }
}
