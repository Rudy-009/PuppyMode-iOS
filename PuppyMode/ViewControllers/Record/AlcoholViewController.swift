//
//  AlcoholViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit

class AlcoholViewController: UIViewController {
    private let alcoholView = AlcoholView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = alcoholView
        
        setDelegate()
        setAction()
    }
    
    // MARK: - function
    private func setDelegate() {
        alcoholView.alcoholCollectionView.dataSource = self
    }
    
    private func setAction() {
        alcoholView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - extension
extension AlcoholViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlcoholKindCollectionViewCell.identifier, for: indexPath) as? AlcoholKindCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = ["소주", "맥주", "와인", "위스키", "기타"]
        cell.titleLabel.text = list[indexPath.row]
        return cell
    }
}
