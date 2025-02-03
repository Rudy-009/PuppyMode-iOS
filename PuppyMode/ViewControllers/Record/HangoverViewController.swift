//
//  HangoverViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 15/01/2025.
//

import UIKit
import Alamofire

class HangoverViewController: UIViewController {
    private let hangoverView = HangoverView()
    private var hangoverList: [HangoverModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view = hangoverView
        
        setDelegate()
        setAction()
        setAPI()
    }
    
    // MARK: - function
    private func setDelegate() {
        hangoverView.hangoverCollectionView.dataSource = self
    }
    
    private func setAction() {
        hangoverView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        hangoverView.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        hangoverView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setAPI() {
        let url = "https://puppy-mode.site/drinks/hangover"
        
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
            print("JWT Token not found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(jwt)",
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: HangoverResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.hangoverList = data.result.map { HangoverModel(hangoverId: $0.hangoverId, hangoverName: $0.hangoverName, imageUrl: $0.imageUrl) }
                self.hangoverView.hangoverCollectionView.reloadData()
            case .failure(let error):
                print("Error fetching hangover data: \(error)")
            }
        }
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func skipButtonTapped() {
        hangoverView.skipButton.backgroundColor = .main
        let drinkingVC = DrinkingRecordViewController()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(drinkingVC, animated: true)
    }
    
    @objc
    private func nextButtonTapped() {
        hangoverView.nextButton.backgroundColor = .main
        let drinkingVC = DrinkingRecordViewController()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(drinkingVC, animated: true)
    }
}

// MARK: - extension
extension HangoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hangoverList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HangoverCollectionViewCell.identifier, for: indexPath) as? HangoverCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let hangover = hangoverList[indexPath.row]
        cell.hangoverLabel.text = hangover.hangoverName
        
        return cell
    }
}
