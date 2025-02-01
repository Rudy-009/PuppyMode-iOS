//
//  AddressSearchModalViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit
import WebKit

import UIKit
import WebKit

protocol AddressSearchDelegate: AnyObject {
    func didSelectAddress(_ roadAddress: String)
}

class AddressSearchModalViewController: UIViewController {
    
    private var webView: WKWebView!
    weak var delegate: AddressSearchDelegate? // Delegate 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadPostcodeHTML()
    }
    
    private func setupWebView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: config)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(webView)
    }
    
    private func loadPostcodeHTML() {
        if let url = URL(string: "https://ybseok.github.io/postcode/") {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("HTML 파일을 로드할 수 없습니다.")
        }
    }
}

// MARK: - WKNavigationDelegate

extension AddressSearchModalViewController: WKNavigationDelegate {}

// MARK: - WKScriptMessageHandler

extension AddressSearchModalViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "callBackHandler", let postData = message.body as? [String: Any],
           let roadAddress = postData["roadAddress"] as? String {
            
            print("도로명 주소:", roadAddress)
            
            // Delegate를 통해 부모 뷰 컨트롤러로 데이터 전달
            delegate?.didSelectAddress(roadAddress)
            
            dismiss(animated: true, completion: nil) // 모달 닫기
        }
    }
}
