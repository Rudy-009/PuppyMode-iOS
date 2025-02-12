//
//  RenameView.swift
//  PuppyMode
//
//  Created by 김민지 on 1/14/25.
//

import UIKit
import SnapKit

class RenameView: UIView {
    
    private lazy var renameLabel = UILabel().then { label in
        label.text = "강아지에게 이름을 지어주세요!"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 20)
    }
    
    public lazy var renameTextField = UITextField().then { textField in
        textField.placeholder = "이름"
        textField.textAlignment = .center
        textField.borderStyle = . none
        
        let underline = UIView()
        underline.backgroundColor = .gray
        
        textField.addSubview(underline)
        underline.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    public lazy var renameSaveButton = UIButton().then { button in
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        button.backgroundColor = .main
        button.layer.cornerRadius = 10
    }
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addComponents() {
        
        self.addSubview(renameLabel)
        renameLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(self.safeAreaLayoutGuide).offset(74)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(renameTextField)
        renameTextField.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(renameLabel.snp.bottom).offset(74)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview().inset(42)
        }
        
        self.addSubview(renameSaveButton)
        renameSaveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(47)
            make.height.equalTo(60)
        }
    }
}
