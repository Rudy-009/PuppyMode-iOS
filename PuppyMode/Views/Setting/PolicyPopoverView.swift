//
//  PolicyPopoverView.swift
//  PuppyMode
//
//  Created by 이승준 on 1/12/25.
//

import UIKit

class PolicyPopoverView: UIView {
    
    private lazy var frameView = UIView().then { frame in
        frame.layer.cornerRadius = 10
        frame.layer.masksToBounds = true
        frame.backgroundColor = .white
    }
    
    private lazy var titleLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Bold", size: 22)
    }
    
    private lazy var scrollView = UIScrollView().then { scroll in
        scroll.contentSize = CGSize(width: 305, height: 146)
        scroll.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        scroll.isDirectionalLockEnabled = true  // 한 방향으로만 스크롤 가능
        scroll.alwaysBounceVertical = true  // 세로 스크롤 바운스 효과 활성화
        scroll.alwaysBounceHorizontal = false  // 가로 스크롤 바운스 효과 비활성화
    }
    
    private lazy var policyLabel = UILabel().then { label in
        label.textColor = UIColor(red: 0.467, green: 0.467, blue: 0.467, alpha: 1)
        label.font = UIFont(name: "NotoSansKR-Light", size: 13)
        label.numberOfLines = 300
    }
    
    public lazy var confirmButton = UIButton().then { btn in
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        btn.titleLabel?.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        btn.backgroundColor = .main
        btn.layer.cornerRadius = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() {
        self.addSubview(frameView)
        
        frameView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(316)
        }
        
        frameView.addSubview(titleLabel)
        frameView.addSubview(scrollView)
        scrollView.addSubview(policyLabel)
        
        frameView.addSubview(confirmButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(146)
        }
        
        policyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.width.equalTo(scrollView.snp.width).offset(-20)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(46)
            make.width.equalTo(150)
        }
        
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        policyLabel.text = content
    }

}

#Preview{
    PolicyPopoverViewController()
}
