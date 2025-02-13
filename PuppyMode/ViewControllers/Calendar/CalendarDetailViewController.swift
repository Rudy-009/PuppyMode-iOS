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
    let hangoverDummy: [String] = [
        "머리가 아파요", "토할 것 같아요"
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
        calendarDetailView.hangoverTableView.dataSource = self
        calendarDetailView.hangoverTableView.delegate = self
    }
    
    private func setAction() {
        calendarDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func updateTableViewHeight() {
        let rowCount = calendarDetailView.alcoholTableView.numberOfRows(inSection: 0)
        let totalHeight = 53 * rowCount
        
        let hangoverRowCount = calendarDetailView.hangoverTableView.numberOfRows(inSection: 0)
        let hangoverTotalHeight = 50 * hangoverRowCount

        if hangoverRowCount == 0 {
            // 숙취 관련 뷰 숨김
            calendarDetailView.hangoverBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(calendarDetailView.intakeBackgroundView.snp.bottom).offset(0)
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.height.equalTo(0)
            }
            
            calendarDetailView.hangoverTitleLabel.snp.remakeConstraints {
                $0.height.equalTo(0)
            }
            
            calendarDetailView.feedBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(calendarDetailView.intakeBackgroundView.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.bottom.equalTo(calendarDetailView.scrollView.snp.bottom)
            }
        } else {
            // 숙취 관련 뷰 표시
            calendarDetailView.hangoverBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(calendarDetailView.intakeBackgroundView.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(20)
            }
            
            calendarDetailView.hangoverTitleLabel.snp.remakeConstraints {
                $0.top.equalTo(calendarDetailView.hangoverBackgroundView.snp.top).offset(27)
                $0.left.equalTo(calendarDetailView.hangoverBackgroundView.snp.left).offset(35)
            }
            
            calendarDetailView.feedBackgroundView.snp.remakeConstraints {
                $0.top.equalTo(calendarDetailView.hangoverBackgroundView.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.bottom.equalTo(calendarDetailView.scrollView.snp.bottom)
            }
        }

        // 음주 테이블 높이 조정
        calendarDetailView.alcoholTableView.snp.updateConstraints {
            $0.height.equalTo(totalHeight)
        }
        
        // 숙취 테이블 높이 조정
        calendarDetailView.hangoverTableView.snp.updateConstraints {
            $0.height.equalTo(hangoverTotalHeight)
        }

        // UI 애니메이션 적용 (레이아웃 즉시 반영)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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
        if tableView == calendarDetailView.alcoholTableView {
            return dummy.count
        } else if tableView == calendarDetailView.hangoverTableView {
            return hangoverDummy.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == calendarDetailView.alcoholTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarAlcoholTableViewCell.identifier, for: indexPath) as? CalendarAlcoholTableViewCell else {
                return UITableViewCell()
            }
            
            let item = dummy[indexPath.row]
            cell.alcoholLabel.text = item.alcohol
            cell.intakeLabel.text = item.intake
            
            return cell
        } else if tableView == calendarDetailView.hangoverTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarHangoverTableViewCell.identifier, for: indexPath) as? CalendarHangoverTableViewCell else {
                return UITableViewCell()
            }
            
            let item = hangoverDummy[indexPath.row]
            cell.hangoverLabel.text = item
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == calendarDetailView.alcoholTableView {
            return 53
        } else if tableView == calendarDetailView.hangoverTableView {
            return 50
        }
        return 0
    }
    
    func reloadTableView() {
        calendarDetailView.alcoholTableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableViewHeight()
        }
    }
}
