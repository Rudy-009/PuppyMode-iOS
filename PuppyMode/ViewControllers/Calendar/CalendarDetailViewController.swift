//
//  CalendarDetailViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 28/01/2025.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    public let calendarDetailView = CalendarDetailView()
    
    // 테스트값
    struct Alcohol {
        let alcohol: String
        let intake: String
    }
    let dummy = [
        Alcohol(alcohol: "참이슬 360ml", intake: "1.5병"),
        Alcohol(alcohol: "새로 360ml", intake: "1.5병"),
        Alcohol(alcohol: "처음처럼 360ml", intake: "1.5병"),
        Alcohol(alcohol: "테라 360ml", intake: "2잔"),
        Alcohol(alcohol: "카스 360ml", intake: "2잔"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarDetailView
        
        setDelegate()
        setAction()
        
        calendarDetailView.alcoholTableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableViewHeight()
        }
    }
    
    // MARK: - function
    private func setDelegate() {
        calendarDetailView.alcoholTableView.dataSource = self
        calendarDetailView.alcoholTableView.delegate = self
    }
    
    private func setAction() {
        calendarDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func updateTableViewHeight() {
        let rowCount = calendarDetailView.alcoholTableView.numberOfRows(inSection: 0)
        let totalHeight = 53 * rowCount

        calendarDetailView.alcoholTableView.snp.updateConstraints {
            $0.height.equalTo(totalHeight)
        }
    }
    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - extension
extension CalendarDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarAlcoholTableViewCell.identifier, for: indexPath) as? CalendarAlcoholTableViewCell else {
            return UITableViewCell()
        }
        
        let item = dummy[indexPath.row]
        cell.alcoholLabel.text = item.alcohol
        cell.intakeLabel.text = item.intake
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func reloadTableView() {
        calendarDetailView.alcoholTableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableViewHeight()
        }
    }
}
