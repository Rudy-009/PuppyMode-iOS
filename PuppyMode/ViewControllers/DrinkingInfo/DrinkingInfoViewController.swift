//
//  DrinkingInfoViewController.swift
//  PuppyMode
//
//  Created by 박준석 on 1/19/25.
//

import UIKit

struct AlcoholItem {
    let imageName: String  // 이미지 이름
    let name: String       // 술 이름
    let percentage: String // 도수
}

class DrinkingInfoViewController: UIViewController, UICollectionViewDelegate {
    
    // View 객체 생성
    private let drinkingInfoView = DrinkingInfoView()
    
    // 캐러셀 데이터 저장
    private var alcoholItems: [AlcoholItem] = []
    
    override func loadView() {
        self.view = drinkingInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupActions()
        configureData()
        
        drinkingInfoView.carouselCollectionView.delegate = self
    }
    
    private func setupNavigationBar() {
        // Create a custom navigation bar container
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor(hex: "#FBFBFB")
        view.addSubview(navigationBar)
        
        // Add constraints for the navigation bar using SnapKit
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56) // Adjust height as needed
        }
        
        // Create a title label for the navigation bar
        let titleLabel = UILabel()
        titleLabel.text = "주량 정보"
        titleLabel.textColor = UIColor(hex: "#3C3C3C")
        titleLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .center
        navigationBar.addSubview(titleLabel)
        
        // Add constraints for the title label using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(navigationBar)
        }
        
        // Create a close button (back button) for the left side of the navigation bar
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "left_arrow"), for: .normal) // Replace with your back arrow image name
        closeButton.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        navigationBar.addSubview(closeButton)
        
        // Add constraints for the close button using SnapKit
        closeButton.snp.makeConstraints { make in
            make.leading.equalTo(navigationBar).offset(37)
            make.centerY.equalTo(navigationBar)
            make.width.equalTo(13)
            make.height.equalTo(20)
        }
    }

    
    // 뒤로가기 버튼 동작
    @objc private func didTapBackButton() {
        // Access the tab bar controller and switch to the "Home" tab
        if let tabBarController = self.tabBarController as? BaseViewController {
            UIView.transition(with: tabBarController.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                tabBarController.selectedIndex = 0 // Set the selected index to 0 (homeVC)
            }, completion: nil)
        } else if let window = UIApplication.shared.windows.first {
            // If not already in a tab bar controller, reset the root view to BaseViewController with animation
            let baseVC = BaseViewController()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = baseVC
            }, completion: nil)
        }
    }

    
    // 버튼 액션 설정
    private func setupActions() {
        drinkingInfoView.makeAppointmentButton.addTarget(self, action: #selector(didTapMakeAppointmentButton), for: .touchUpInside)
    }
    
    @objc private func didTapMakeAppointmentButton() {
        print("오늘 술 마실 거에요! 버튼 클릭됨")
        let modalVC = AppointmentModalViewController()
        modalVC.modalPresentationStyle = .overFullScreen // 화면 전체를 덮는 스타일로 설정
        modalVC.modalTransitionStyle = .crossDissolve   // 부드러운 전환 효과 추가
        present(modalVC, animated: true, completion: nil) // 모달 표시
    }
    
    // 데이터 구성
    private func configureData() {
        let carouselData: [AlcoholItem] = [
            AlcoholItem(imageName: "chamisul", name: "참이슬 후레쉬", percentage: "16.0도"),
            AlcoholItem(imageName: "likefirsttime", name: "처음처럼", percentage: "16.5도"),
            AlcoholItem(imageName: "jinro", name: "진로", percentage: "17.0도"),
            AlcoholItem(imageName: "tera", name: "테라", percentage: "4.5도"),
            AlcoholItem(imageName: "cass", name: "카스", percentage: "4.7도"),
            AlcoholItem(imageName: "krush", name: "크러쉬", percentage: "4.5도"),
            AlcoholItem(imageName: "kelly", name: "켈리", percentage: "4.7도")
        ]
        
        alcoholItems = carouselData
        drinkingInfoView.setCarouselData(alcoholItems)
        
        // 초기 활성화된 아이템에 따라 라벨 설정
        if let firstItem = alcoholItems.first {
            drinkingInfoView.alcoholNameLabel.text = firstItem.name
            drinkingInfoView.alcoholPercentageLabel.text = firstItem.percentage
        }
    }
    
    private func updateLabels(forItemAt index: Int) {
        guard index < alcoholItems.count else { return } // 데이터 범위 확인
        
        let item = alcoholItems[index] // 활성화된 아이템 가져오기
        print("현재 활성화 인덱스:", item) // 디버깅용 출력
        
        // 라벨 업데이트
        drinkingInfoView.alcoholNameLabel.text = item.name
        drinkingInfoView.alcoholPercentageLabel.text = item.percentage
        
        print("현재 활성화된 아이템:", item.name, item.percentage) // 디버깅용 출력
    }
    
}

extension DrinkingInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        
        // Calculate the center position of the collection view
        let centerX = collectionView.bounds.size.width / 2 + collectionView.contentOffset.x
        
        var closestIndex: Int?
        var minimumDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for cell in collectionView.visibleCells {
            let cellCenterX = cell.center.x
            
            // Calculate the distance between the center of the collection view and the cell
            let distance = abs(centerX - cellCenterX)
            
            if distance < minimumDistance {
                minimumDistance = distance
                closestIndex = collectionView.indexPath(for: cell)?.item
            }
            
            // Scale cells based on their distance from the center (closer cells appear larger)
            let scale = max(0.8, 1 - distance / collectionView.bounds.size.width)
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        // Update labels based on the closest cell to the center
        if let closestIndex = closestIndex {
            updateLabels(forItemAt: closestIndex)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset targetContentOffsetPointer: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // Calculate cell width including spacing
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        // Calculate proposed offset for snapping behavior
        let proposedOffset = targetContentOffsetPointer.pointee.x
        
        // Determine the index of the nearest cell
        var index = round((proposedOffset + scrollView.contentInset.left) / cellWidthIncludingSpacing)
        
        // Clamp index to ensure it doesn't exceed bounds
        let maxIndex = max(0, collectionView.numberOfItems(inSection: 0) - 1)
        index = min(max(0, index), CGFloat(maxIndex))
        
        // Calculate new offset for snapping to center
        let newOffsetX = index * cellWidthIncludingSpacing - scrollView.contentInset.left
        
        // Update targetContentOffset to snap to the nearest cell
        targetContentOffsetPointer.pointee.x = newOffsetX
    }
}
