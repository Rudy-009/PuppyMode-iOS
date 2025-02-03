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
        items = DecoItemModel.hatData[0].items
        
        setupNavigationBar(title: "꾸미기")
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoriesFromServer()
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
        print("dd")
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
                let categories = response.result.categories.map {
                    Category(categoryId: $0.categoryId, name: $0.name, itemCount: $0.itemCount)
                }
                
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
        
        // 카테고리 ID를 URL에 동적으로 삽입
        let urlString = K.String.puppymodeLink + "/puppies/\(categoryId)/items"
        
        AF.request(urlString,
                   method: .get,
                   headers: headers)
            .responseDecodable(of: PuppyItemResponse.self) { [weak self] response in
                    
                guard let _ = self else { return }
                    
                switch response.result {
                case .success(let response):
                    print("아이템 불러오기 성공")
                    
                    // items 배열 업데이트
                    self?.items = response.result.items.map { item in
                        DecoItemModel(itemId: item.itemId, image: UIImage(named: item.image_url) ?? UIImage(),
                                      price: "\(item.price)",
                                      isPurchased: item.isPurchased)
                    }
                    
                case .failure(let error):
                    print("Network Error: \(error.localizedDescription)")
                }
            }
    }


}

// MARK: - UICollectionViewDataSource
extension DecoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DecoItemViewCell.identifier, for: indexPath) as! DecoItemViewCell
        let item = items[indexPath.item]
        cell.decoItemImageView.image = item.image
        cell.decoItemLabel.text = item.price
        cell.lockImageView.isHidden = item.isPurchased

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DecoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        
        // 선택된 아이템이 속한 카테고리 찾기
        var categoryId: Int?
        for category in DecoItemModel.hatData {
            // 아이템이 카테고리의 아이템 목록에 포함되어 있는지 확인
            if category.items.contains(where: { $0.itemId == selectedItem.itemId }) {
                categoryId = category.categoryId
                break
            }
        }
        
        // 선택한 아이템의 카테고리 ID와 아이템 ID 출력
        if let categoryId = categoryId {
            print("선택한 카테고리 ID: \(categoryId) ,아이템 ID: \(selectedItem.itemId)")
        }
        
        // 아이템 가격이 0인 경우 도전 과제 아이템 안내
        if selectedItem.price == "" {
            showAlert(title: "", message: "도전 과제로 얻는 아이템은 \n구매할 수 없습니다.")
        } else {
            // 아이템 구매 확인
            let alert = UIAlertController(title: nil, message: "아이템을 구매하시겠습니까?", preferredStyle: .alert)
            
            let purchaseAction = UIAlertAction(title: "구매", style: .default) { _ in
                self.purchaseItem(item: selectedItem)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(purchaseAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // 아이템 구매 처리 (구체적인 구매 로직은 추후 구현)
    private func purchaseItem(item: DecoItemModel) {
        // 구매 후 서버 연동
        guard let index = items.firstIndex(where: { $0.itemId == item.itemId }) else { return }
        let indexPath = IndexPath(item: index, section: 0)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DecoItemViewCell {
            cell.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            cell.lockImageView.isHidden = true
            cell.decoItemLabel.isHidden = true
        }
    }
    
    // 알림창 표시 메서드
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

