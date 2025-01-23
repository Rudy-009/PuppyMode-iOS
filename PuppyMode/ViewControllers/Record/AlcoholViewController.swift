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
        alcoholView.alcoholTableView.dataSource = self
        alcoholView.alcoholTableView.delegate = self
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

extension AlcoholViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AlcoholDetailModel.dummy().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlcoholDetailTableViewCell.identifier, for: indexPath) as? AlcoholDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let item = AlcoholDetailModel.dummy()[indexPath.row]
        cell.titleLabel.text = "\(item.name) \(item.volume)ml"
        cell.degreeLabel.text = "\(item.degree)도"
        return cell
    }
}
