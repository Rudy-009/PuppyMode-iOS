//
//  DrinkingInfoView.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit
import SnapKit
import Then
import SwiftUI

let DrinkingProgressBar = DrinkingProgressBarView()

// MARK: - Carousel Cell

class CarouselCell: UICollectionViewCell {
    
    static let identifier = "CarouselCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 셀 배경색 설정
        contentView.backgroundColor = UIColor(hex: "#FFFFFF")
        
        // 그림자 효과 적용
        contentView.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        contentView.layer.shadowOpacity = 0.25 // 그림자 투명도 (rgba의 alpha 값)
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4) // 그림자 위치 (x: 0px, y: 4px)
        contentView.layer.shadowRadius = 4 // 그림자 흐림 반경 (blur 효과)
        
        // 테두리 설정
        contentView.layer.cornerRadius = 10 // 둥근 모서리 반경
        contentView.layer.borderWidth = 1   // 테두리 두께
        contentView.layer.borderColor = UIColor(hex: "#A8A8A8").cgColor // 테두리 색상
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

class DrinkingInfoView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    var alcoholItems: [AlcoholItem] = [] // 전체 데이터를 저장할 배열
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alcoholItems.count // 전체 데이터 개수 반환
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
        
        let item = alcoholItems[indexPath.item]
        print(item)
        cell.configure(withImageName: item.imageName) // 이미지 설정
        
        return cell
    }
    
    private func adjustItemSizes() {
        for cell in carouselCollectionView.visibleCells {
            let centerX = carouselCollectionView.bounds.size.width / 2 + carouselCollectionView.contentOffset.x
            let cellCenterX = cell.center.x
            let distance = abs(centerX - cellCenterX)
            let scale = max(0.8, 1 - distance / carouselCollectionView.bounds.size.width)
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    private func scrollToInitialPosition() {
        guard alcoholItems.count > 0 else { return }
        
        let initialIndexPath = IndexPath(item: 0, section: 0) // 첫 번째 아이템으로 이동
        carouselCollectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
    }

    // Carousel (UICollectionView)
    lazy var carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 셀 간 간격
        layout.itemSize = CGSize(width: 218, height: 247) // 셀 크기 설정
        
        // sectionInset 추가
        let inset = UIScreen.main.bounds.width / 2 - (layout.itemSize.width / 2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false // 페이징 비활성화 (커스텀 중앙 정렬 구현)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Public Method to Set Data
    func setCarouselData(_ items: [AlcoholItem]) {
        self.alcoholItems = items // 전체 데이터를 저장
        self.carouselCollectionView.reloadData() // 컬렉션 뷰 갱신
    }

    // MARK: - Other logics
    let alcoholNameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = UIColor.black
    }
    
    let alcoholPercentageLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor.gray
    }
    
    // Carousel (Image Scroll View)
    let carouselScrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    // makeAppointment Button
    let makeAppointmentButton = UIButton(type: .system).then {
        $0.setTitle("오늘 술 마실 거에요!", for: .normal)
        
        $0.backgroundColor = UIColor(hex: "#73C8B1")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
        $0.setTitleColor(UIColor(hex: "#3C3C3C"), for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        
        DispatchQueue.main.async {
            self.adjustItemSizes()
            self.scrollToInitialPosition()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#FBFBFB")
        
        addSubview(alcoholNameLabel)
        addSubview(alcoholPercentageLabel)
        
        addSubview(carouselCollectionView)
        
        addSubview(DrinkingProgressBar)
        
        addSubview(makeAppointmentButton)
    }
    
    private func setupLayout() {
        
        alcoholNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(85)
            make.height.equalTo(20)
        }
        
        alcoholPercentageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.right.equalToSuperview().offset(-85)
            make.height.equalTo(20)
        }
        
        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalTo(alcoholPercentageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(247) // Adjust height as needed for carousel items
        }
        
        DrinkingProgressBar.snp.makeConstraints { make in
            make.bottom.equalTo(makeAppointmentButton.snp.top).offset(-81)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(175)
        }
        
        makeAppointmentButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
    }
    
}
