//
//  DecorationViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit
import Alamofire

class DecoViewController: UIViewController {
    private var selectedButton: UIButton?           // 이전에 눌린 버튼을 저장
    private var collectionView: UICollectionView!
    private var items: [DecoItemModel] = []         // 컬렉션 뷰에 표시할 데이터 배열
    private var selectedLevel: Int = 1              // 초기 레벨 설정
    private var purchasedItemIds: Set<Int> = []
    
    private lazy var decoView: DecoView = {
        let view = DecoView()
    
        
        view.renamebutton.addTarget(self, action: #selector(renameButtonTapped), for: .touchUpInside)
        view.forEachButton { button in
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
        

        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = decoView
        
        // '모자' 버튼을 눌린 상태로 설정
        if let hatButton = view.viewWithTag(0) as? UIButton {
            hatButton.isSelected = true
            hatButton.backgroundColor = .darkGray
            hatButton.tintColor = .white
            hatButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        }
         
        // 초기 데이터 설정
        items = DecoItemModel.hatData.flatMap { $0.items } +
                DecoItemModel.clothesData.flatMap { $0.items } +
                DecoItemModel.floorData.flatMap { $0.items } +
                DecoItemModel.houseData.flatMap { $0.items } +
                DecoItemModel.toyData.flatMap { $0.items }
        
        
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoriesFromServer()
        fetchPointFromServer()
        fetchOwnedItemsFromServer()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 109, height: 109)
        layout.minimumInteritemSpacing = 12 // 아이템 간의 최소 간격
        layout.minimumLineSpacing = 14      // 행 간의 최소 간격

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DecoItemViewCell.self, forCellWithReuseIdentifier:DecoItemViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
           
        decoView.backgroundView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(decoView.categoryButtonsScrollView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview()
        }
    }

    
    @objc func renameButtonTapped() {
        let renameVC = RenameViewController()
        navigationController?.pushViewController(renameVC, animated: true)
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        if let previousButton = selectedButton {
            previousButton.backgroundColor = .clear
            previousButton.titleLabel?.font = .systemFont(ofSize: 15)
            previousButton.tintColor = .lightGray
        }
        
        sender.backgroundColor = .darkGray
        sender.tintColor = .white
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        sender.titleLabel?.adjustsFontSizeToFitWidth = true
        sender.titleLabel?.lineBreakMode = .byTruncatingTail


        selectedButton = sender

        guard let categoryName = sender.titleLabel?.text else { return }
        
        // 카테고리 이름에 따라 ID를 전달하여 아이템 불러오기
        switch categoryName {
        case "모자":
            items = DecoItemModel.hatData[0].items
            fetchItemsFromServer(categoryId: 1)
        case "옷":
            items = DecoItemModel.clothesData[0].items
            fetchItemsFromServer(categoryId: 2)
        case "집":
            items = DecoItemModel.houseData[0].items
            fetchItemsFromServer(categoryId: 3)
        case "바닥":
            items = DecoItemModel.floorData[0].items
            fetchItemsFromServer(categoryId: 4)
        case "장난감":
            items = DecoItemModel.toyData[0].items
            fetchItemsFromServer(categoryId: 5)
        default:
            break
        }
        
        collectionView.reloadData() // 데이터 변경 후 컬렉션 뷰 다시 로드
        
    }
    
    // 서버로부터 카테고리 조회
    private func fetchCategoriesFromServer() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        
        AF.request(K.String.puppymodeLink + "/puppies/categories",
                   method: .get,
                   headers: headers)
        .responseDecodable(of: PuppyCategoryResponse.self)  { [weak self] response in
                
            guard let _ = self else { return }
                
            switch response.result {
            case .success(let response):
                print("카테고리 불러오기 성공")
                print(response.result)
                
            case .failure(let error):
                print("Network Error: \(error.localizedDescription)")
            }

        }
    }
    
    // 서버로부터 카테고리별 아이템 조회
    private func fetchItemsFromServer(categoryId: Int) {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        
        // 카테고리 ID로 아이템 리스트 조회
        let urlString = K.String.puppymodeLink + "/puppies/\(categoryId)/items"
        
        AF.request(urlString,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: PuppyItemResponse.self) { [weak self] response in
                    
                guard let _ = self else { return }
                    
                switch response.result {
                case .success(let response):
                    print("아이템 불러오기 성공")
                    
                case .failure(let error):
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
    
    // 서버로부터 포인트 조회
    private func fetchPointFromServer() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        AF.request(K.String.puppymodeLink + "/puppies/points",
                   method: .get,
                   headers: headers)
        .responseDecodable(of: PuppyPointResponse.self)  { [weak self] response in
                
            guard let _ = self else { return }
                
            switch response.result {
            case .success(let response):
                print("포인트 조회 성공: \(response.result)")
                
                if let point = response.result {
                    self?.setupNavigationBar(title: "꾸미기", rightText: "\(point)P")
                }
                
            case .failure(let error):
                print("Network Error: \(error.localizedDescription)")
            }

        }
    }


}

// 구매한 아이템을 저장하는 Set
var purchasedItemIds: Set<Int> = []

// MARK: - UICollectionViewDataSource
extension DecoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DecoItemViewCell.identifier, for: indexPath) as! DecoItemViewCell
        
        let item = items[indexPath.item]
        let isPurchased = purchasedItemIds.contains(item.itemId)

        cell.decoItemImageView.image = item.image
        cell.decoItemLabel.text = item.price

        updateCellUI(cell, isPurchased: isPurchased)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DecoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        
        // 선택된 아이템이 속한 카테고리 찾기
        let allCategories = [DecoItemModel.hatData, DecoItemModel.clothesData, DecoItemModel.houseData, DecoItemModel.floorData, DecoItemModel.toyData]

        var categoryId: Int?

        for categoryList in allCategories { // 여러 개의 카테고리 배열을 순회
            for category in categoryList {
                if category.items.contains(where: { $0.itemId == selectedItem.itemId }) {
                    categoryId = category.categoryId
                    break
                }
            }
            if categoryId != nil { break } // 찾았으면 더 이상 반복할 필요 없음
        }
        
        // 선택한 아이템의 카테고리 ID와 아이템 ID 출력
        if let categoryId = categoryId {
            print("선택한 카테고리 ID: \(categoryId) ,아이템 ID: \(selectedItem.itemId)")
        }

        
        // 아이템 소유가 안된 경우
        if selectedItem.isPurchased == false {
            // 도전 과제 아이템은 구매 불가
            if selectedItem.mission_item {
                showAlert(title: "", message: "도전 과제로 얻는 아이템은 \n구매할 수 없습니다.")
                return
            }
            
            // 아이템 구매 확인
            let alert = UIAlertController(title: nil, message: "아이템을 구매하시겠습니까?", preferredStyle: .alert)
            
            let purchaseAction = UIAlertAction(title: "구매", style: .default) { _ in
                self.postPurchaseItemToServer(categoryId: categoryId!, itemId: selectedItem.itemId)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(purchaseAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        
        // 아이템 소유가 된 경우
        if selectedItem.isPurchased == true {
            
        }

    }

    
    
    private func postPurchaseItemToServer(categoryId: Int, itemId: Int) {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        let urlString = K.String.puppymodeLink + "/puppies/\(categoryId)/items/\(itemId)"
        
        AF.request(urlString,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: PuppyPurchaseResponse.self) { [weak self] response in
        
                guard let _ = self else { return }
                    
                switch response.result {
                case .success(let response):
                    print("아이템 구매하기 서버 연동 성공")
                    
                    // 아이템 구매 성공 메시지 떠야지만 구매한 아이템 저장
                    if let purchasedItem = self?.items.first(where: { $0.itemId == response.result?.itemId }) {
                        self?.purchaseItem(item: purchasedItem)
                    }
                    
                case .failure(let error):
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
    
    
    private func purchaseItem(item: DecoItemModel) {
        purchasedItemIds.insert(item.itemId) // 구매한 아이템 저장
         
        guard let index = items.firstIndex(where: { $0.itemId == item.itemId }) else { return }
        let indexPath = IndexPath(item: index, section: 0)
         
        if let cell = collectionView.cellForItem(at: indexPath) as? DecoItemViewCell {
            updateCellUI(cell, isPurchased: true)
        }
         
        collectionView.reloadItems(at: [indexPath]) // 변경된 아이템만 리로드
     }
     
    private func updateCellUI(_ cell: DecoItemViewCell, isPurchased: Bool) {
        if isPurchased {
            cell.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            cell.lockImageView.isHidden = true
            cell.decoItemLabel.isHidden = true
        } else {
            cell.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            cell.lockImageView.isHidden = false
            cell.decoItemLabel.isHidden = false
        }
    }
    
    // 알림창 표시 메서드
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func fetchOwnedItemsFromServer() {
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(KeychainService.get(key: UserInfoKey.jwt.rawValue)!)"
        ]
        let urlString = K.String.puppymodeLink + "/puppies/items"
        
        AF.request(urlString,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: PuppyOwnedItemResponse.self) { [weak self] response in
        
                guard let _ = self else { return }
                    
                switch response.result {
                case .success(let response):
                    print("소유한 아이템 조회 서버 연동 성공")
                    
                    guard let self = self else { return }

                    // 서버에서 받은 소유한 아이템 ID를 저장
                    self.purchasedItemIds = Set(response.result?.compactMap { $0.itemId } ?? [])
                    print("서버에서 받은 아이템 ID들: \(self.purchasedItemIds)")

                    
                    // items 배열에서 해당 아이템들의 isPurchased 업데이트
                    self.items = self.items.map { item in
                        var newItem = item
                        if self.purchasedItemIds.contains(newItem.itemId) {
                            newItem.isPurchased = true
                            print("✅ 구매한 아이템 업데이트: \(newItem.itemId)")
                        }
                        return newItem
                    }


                    // UI 업데이트
                    self.updatePurchasedItemsUI()

                    
                case .failure(let error):
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }
    
    private func updatePurchasedItemsUI() {
        for (index, item) in items.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) as? DecoItemViewCell {
                updateCellUI(cell, isPurchased: item.isPurchased)
            }
        }
        
        collectionView.reloadData()
    }

}

