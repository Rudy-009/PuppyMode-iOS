//
//  PuppySelectionViewController.swift
//  PuppyMode
//
//  Created by 이승준 on 1/26/25.
//

import UIKit
import Alamofire

class PuppySelectionViewController: UIViewController {
    
    private let puppySelectionView = PuppySelectionView()
    private let confirmVC = ConfirmPuppySelectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = puppySelectionView
        self.view.backgroundColor = UIColor(red: 0.983, green: 0.983, blue: 0.983, alpha: 1)
        connectButtonActions()
    }
    
    private func connectButtonActions() {
        puppySelectionView.cardButton04.addTarget(self, action: #selector(puppyChosed(_:)), for: .touchUpInside)
        puppySelectionView.cardButton03.addTarget(self, action: #selector(puppyChosed(_:)), for: .touchUpInside)
        puppySelectionView.cardButton02.addTarget(self, action: #selector(puppyChosed(_:)), for: .touchUpInside)
        puppySelectionView.cardButton01.addTarget(self, action: #selector(puppyChosed(_:)), for: .touchUpInside)
        puppySelectionView.startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func startButtonPressed() {
        RootViewControllerService.toBaseViewController()
    }
    
    @objc
    private func puppyChosed(_ sender: PuppyCardButtonView) {
        puppySelectionView.showDimAndActiveAnimation(sender)
        print("btn pressed")
    }
    
    @objc
    private func showConfirmVC() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        
        AF.request(K.String.puppymodeLink + "/puppies",
                   method: .post,
                   headers: headers)
            .responseDecodable(of: PuppySelectionResponse.self) { [weak self] response in
                
                guard let self = self else { return }
                
                switch response.result {
                case .success(let puppyResponse) :
                    if puppyResponse.isSuccess {
                        guard let puppy = convertToPuppyType(str: puppyResponse.result.puppyType) else {
                            // Wrong Puppy String => 강아지 정보 삭제, 다시 요청 or 다시 뽑게 만들기?
                            return
                        }
                        confirmVC.configure(puppy: puppy, imageURL: puppyResponse.result.puppyImageUrl)
                        present(confirmVC,animated: false)
                    } else {
                        print("Puppy Random Generate API Error: \(puppyResponse.message)")
                    }
                case .failure(let error) :
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
    
    func convertToPuppyType(str: String) -> PuppyEnum? {
        switch str {
        case "포메라니안":
            return .pomeranian
        case "웰시코기":
            return .welshCorgi
        case "비숑":
            return .bichon
        default:
            print("No such Puppy \(str)")
            return nil
        }
    }
    
}

import SwiftUI
#Preview{
    PuppySelectionViewController()
}
