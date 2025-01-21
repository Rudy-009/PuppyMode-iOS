//
//  HangoverViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 15/01/2025.
//

import UIKit

class HangoverViewController: UIViewController {
    private let hangoverView = HangoverView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = hangoverView
        
        setDelegate()
        setAction()
    }
    
    // MARK: - function
    private func setDelegate() {
        hangoverView.hangoverCollectionView.dataSource = self
    }
    
    private func setAction() {
        hangoverView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - extension
extension HangoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HangoverCollectionViewCell.identifier, for: indexPath) as? HangoverCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let list = HangoverModel.dummy()
        cell.hangoverLabel.text = list[indexPath.row].label
        return cell
    }
}
