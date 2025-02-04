//
//  CollectionViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/21/25.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController {
        
    private lazy var collectionView: CollectionView = {
        let view = CollectionView()
        view.collectionTableView.delegate = self
        view.collectionTableView.dataSource = self
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = collectionView
        
        setupNavigationBar(title: "컬렉션", rightText: "")
        getCollectionfromServer()
    
    }
    
    private func getCollectionfromServer() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        
        AF.request(K.String.puppymodeLink + "/collections",
                   method: .get,
                   headers: headers)
            .responseDecodable(of: CollectionResponse.self)  { [weak self] response in
                
                guard let _ = self else { return }
                
                switch response.result {
                case .success(let response) :
                    print(response.result)
                case .failure(let error) :
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource{
    
    // 셀 등록
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.configureSeparator(isLastCell: isLastCell)
        
        return cell
    }
    
    // 셀 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95 + 30
    }
}
