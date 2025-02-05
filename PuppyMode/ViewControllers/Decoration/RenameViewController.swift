//
//  RenameViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/14/25.
//

import UIKit
import Alamofire

class RenameViewController: UIViewController {
    
    var name: String = ""
    
    private lazy var renameView: RenameView = {
        let view = RenameView()
        
        view.renameSaveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.renameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = renameView
        
        setupNavigationBar(title: "이름 수정", rightText: "")

    }
    
    @objc
    private func textFieldDidChange() {
        let hasText = !(renameView.renameTextField.text ?? "").isEmpty
        renameView.renameSaveButton.isEnabled = hasText
        renameView.renameSaveButton.setTitleColor(hasText ? .black : .white, for: .normal)
    }
    
    @objc
    private func saveButtonTapped() {
        // 이름 값 확인
        guard let newName = renameView.renameTextField.text, !newName.isEmpty else { return }
        // 서버로 바뀐 이름 전송
        self.name = newName
        
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        
        let parameters: [String: Any] = [
            "newPuppyName": self.name
          ]
        
        AF.request(K.String.puppymodeLink + "/puppies",
                   method: .patch,
                   parameters: parameters,
                   headers: headers)
        .responseDecodable(of: PuppyNameResponse.self)  { [weak self] response in
                
                guard let _ = self else { return }
                
                switch response.result {
                case .success(let response) :
                    print("바뀐 이름: \(response.result)")
                    self?.navigationController?.popViewController(animated: true)  // 성공하면 이전화면으로 돌아가기
                case .failure(let error) :
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
}
