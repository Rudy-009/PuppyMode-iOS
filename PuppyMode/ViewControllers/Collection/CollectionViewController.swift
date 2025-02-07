//
//  CollectionViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/21/25.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController {
    
    private var collections: [userCollectionDTO] = []   // 컬렉션 데이터 저장
    private var decoItems: [DecoItemModel] = []
        
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
                    print("컬렉션 조회 성공")
                    print(response.result)
                    self?.collections = (response.result?.userCollectionViewDTOs)!
                    DispatchQueue.main.async {
                        self?.collectionView.collectionTableView.reloadData()  // UI 업데이트
                    }
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
        
        let collection = collections[indexPath.row]
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        // DecoItemModel에서 collection의 puppyItemId와 일치하는 item 찾기
        let matchingItem = decoItems.first { $0.itemId == collection.puppyItemId }

        // 해당 item의 image를 가져오거나, 없으면 기본 이미지 설정
        let itemImage = matchingItem?.image 

                                                       
        cell.configureSeparator(isLastCell: isLastCell)
        cell.configure(
            imageView: itemImage,
            title: collection.collectionName,
            subtitle: collection.hangoverName,
            currentNum: collection.currentNum,
            requiredNum: collection.requiredNum
        )
        
        return cell
    }
    
    // 셀 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    // 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95 + 30
    }
}
