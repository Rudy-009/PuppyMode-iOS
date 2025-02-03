//
//  DecorationViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit
import Alamofire

class DecoViewController: UIViewController {
    private var selectedButton: UIButton?   // 이전에 눌린 버튼을 저장
    private var collectionView: UICollectionView!
    private var items: [DecoItemModel] = [] // 컬렉션 뷰에 표시할 데이터 배열
    
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
        items = DecoItemModel.hatData
        
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
            items = DecoItemModel.hatData
            fetchItemsFromServer(categoryId: 1)
        case "옷":
            items = DecoItemModel.clothesData
            fetchItemsFromServer(categoryId: 2)
        case "집":
            items = DecoItemModel.houseData
            fetchItemsFromServer(categoryId: 3)
        case "바닥":
            items = DecoItemModel.floorData
            fetchItemsFromServer(categoryId: 4)
        case "장난감":
            items = DecoItemModel.toyData
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
//                self?.updateCategory(categories: categories)
                
            case .failure(let error):
                print("Network Error: \(error.localizedDescription)")
            }

        }
    }
    
    private func updateCategory(categories: [Category]) {
        // 서버에서 받은 카테고리 데이터를 기반으로 버튼 태그 설정
        for (index, category) in categories.enumerated() {
            if let button = view.viewWithTag(index) as? UIButton {
                button.setTitle(category.name, for: .normal)
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
                    print(response.result)
                    
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
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DecoViewController: UICollectionViewDelegate {
    // 셀 선택 등의 추가 기능이 필요하다면 여기에 구현
}
