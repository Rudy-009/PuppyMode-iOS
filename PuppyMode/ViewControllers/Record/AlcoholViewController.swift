//
//  AlcoholViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit

class AlcoholViewController: UIViewController {
    private let alcoholView = AlcoholView()
    private var selectedIndexPath: IndexPath?

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
        alcoholView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonTapped() {
        if let indexPath = selectedIndexPath {
            let selectedItem = AlcoholDetailModel.dummy()[indexPath.row]
            print("선택된 셀 정보: \(selectedItem.name) \(selectedItem.volume)ml, \(selectedItem.degree)도")
            
            let intakeVC = IntakeViewController()
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(intakeVC, animated: true)
        } else {
            print("선택된 셀이 없습니다.")
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1).cgColor
        
        // 이전에 선택된 셀 초기화
        if let previousIndexPath = selectedIndexPath,
           let previousCell = tableView.cellForRow(at: previousIndexPath) {
            previousCell.layer.borderWidth = 1
            previousCell.layer.borderColor = UIColor(red: 0.953, green: 0.957, blue: 0.965, alpha: 1).cgColor
        }

        // 현재 선택된 셀
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1).cgColor

        // 현재 선택된 셀의 인덱스를 저장
        selectedIndexPath = indexPath
    }
}
