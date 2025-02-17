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
    public var coinAlermButton = AlermView()

        
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
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.accessToken.rawValue)!)"
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
                    
                    // 알림이 아직 안 떴고, 조건이 충족될 경우에만 띄우기
                    if !UserDefaults.standard.bool(forKey: "isPointAlertShown") {  // UserDefaults에 저장된 값이 false일 때만 실행
                        for collection in self!.collections {
                            if collection.currentNum == collection.requiredNum {
                                self?.showPointAlert()
                                UserDefaults.standard.set(true, forKey: "isPointAlertShown")  // 알림을 띄운 기록 저장
                                break
                            }
                        }
                    }

                case .failure(let error) :
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
    
    private func showPointAlert() {
        // 알림 버튼 위치 설정
        self.view.addSubview(coinAlermButton)
        coinAlermButton.coinLabel.text = "별 하나 휙득"
        
        coinAlermButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(59)
        }
        
        // 알림 버튼 5초 후에 사라지게 설정
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.coinAlermButton.removeFromSuperview()
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
        let itemImage = DecoItemModel.getImageByID(for: collection.puppyItemId)

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
    
    // 셀 선택을 아예 못 하게 막기
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
