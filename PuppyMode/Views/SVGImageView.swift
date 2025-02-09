//
//  SDKImageView.swift
//  PuppyMode
//
//  Created by 이승준 on 2/9/25.
//

import UIKit
import WebKit
import SnapKit
import Then

class SVGImageView: UIView {
    
    private var webImage = WKWebView().then {
        $0.load(URLRequest(url: URL(string: "https://d1le4wcgenmery.cloudfront.net/937200e7-effe-401b-b24f-13bd2d11c4ba아기 비숑.svg")!))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func addComponents() {
        self.addSubview(webImage)
        
        webImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(150)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
