//
//  DecorationViewController.swift
//  PuppyMode
//
//  Created by 김민지 on 1/13/25.
//

import UIKit

class DecoViewController: UIViewController {
    private var selectedButton: UIButton?   // 이전에 눌린 버튼을 저장
    private var collectionView: UICollectionView!
    private var items: [DecoItemModel] = [] // 컬렉션 뷰에 표시할 데이터 배열
    
    private lazy var decoView: DecoView = {
        let view = DecoView()
    
        
        view.renamebutton.addTarget(self, action: #selector(renameButtonTapped), for: .touchUpInside)
        view.forEachButton { button in
            button.addTarget(self, action: #selector(itemButtonTapped), for: .touchUpInside)
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
        
        setupNavigationBar(title: "꾸미기", action: #selector(customBackButtonTapped))
        setupCollectionView()
        
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
            make.top.equalTo(decoView.itemButtonsScrollView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview()
        }
    }

    
    @objc func renameButtonTapped() {
        let renameVC = RenameViewController()
        navigationController?.pushViewController(renameVC, animated: true)
    }
    
    @objc func itemButtonTapped(_ sender: UIButton) {
        if let previousButton = selectedButton {
            previousButton.backgroundColor = .clear
            previousButton.titleLabel?.font = .systemFont(ofSize: 15)
            previousButton.tintColor = .lightGray
        }
        
        sender.backgroundColor = .darkGray
        sender.tintColor = .white
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        selectedButton = sender

        switch sender.tag {
        case 0:
            items = DecoItemModel.hatData
        case 1:
            items = DecoItemModel.faceData
        case 2:
            items = DecoItemModel.clothData
        case 3:
            items = DecoItemModel.faceData
        case 4:
            print("바닥")
        case 5:
            print("장난감")
        default:
            items = []
        }
        
        collectionView.reloadData() // 데이터 변경 후 컬렉션 뷰 다시 로드
        
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
        cell.decoItemLabel.text = item.title
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DecoViewController: UICollectionViewDelegate {
    // 셀 선택 등의 추가 기능이 필요하다면 여기에 구현
}
