//
//  CalendarDetailViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 28/01/2025.
//

import UIKit
import Alamofire
import SDWebImage

class CalendarDetailViewController: UIViewController {
    public let calendarDetailView = CalendarDetailView()
    var selectedDate: String?
    var drinkHistoryId: Int?
    
    var drinkDetails: [DrinkItem] = []
    var hangoverDetails: [HangoverItem] = []
    var feed: Feed?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarDetailView
        
        setDelegate()
        setAction()
        fetchCalendarDetails()
    }
    
    // MARK: - function
    private func setDelegate() {
        calendarDetailView.alcoholTableView.dataSource = self
        calendarDetailView.alcoholTableView.delegate = self
        calendarDetailView.hangoverTableView.dataSource = self
        calendarDetailView.hangoverTableView.delegate = self
    }
    
    private func fetchCalendarDetails() {
        let url = "https://puppy-mode.site/calendar/daily?drinkHistoryId=\(drinkHistoryId ?? 0)"
        print(drinkHistoryId)
        
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
            print("JWT Token not found")
            return
        }
        
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(jwt)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: CalendarDetailResponse.self) { response in
            switch response.result {
            case .success(let data):
                if let result = data.result.first {
                    self.drinkDetails = result.drinkItems
                    self.hangoverDetails = result.hangoverItems ?? []
                    self.feed = result.feed
                    DispatchQueue.main.async {
                        self.updateUI(with: result)
                    }
                }
            case .failure(let error):
                print("Error fetching calendar details: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with result: CalendarDetail) {
        calendarDetailView.alcoholTableView.reloadData()
        calendarDetailView.hangoverTableView.reloadData()
        
        DispatchQueue.main.async {
            self.updateTableViewHeight()
        }
        
        if let feed = self.feed {
            calendarDetailView.feedLabel.text = feed.feedingType
            if let url = URL(string: feed.feedImageUrl) {
                calendarDetailView.feedImage.kf.setImage(with: url)
            }
        }
        
        let drinkAmount = result.drinkAmount

        let safetyValue = result.drinkItems.first?.safetyValue ?? 0
        let maxValue = result.drinkItems.first?.maxValue ?? 0
        
        let safetyBottles = safetyValue / 360
        let safetyGlasses = safetyValue / 50
        
        let maxBottles = maxValue / 360
        let maxGlasses = maxValue / 50
        
        let progress = min(Float(drinkAmount) / Float(maxValue), 1.0)
        calendarDetailView.progressView.progress = progress
        
        calendarDetailView.safeBottleLabel.text = "\(safetyBottles)병"
        calendarDetailView.safeGlassLabel.text = "\(safetyGlasses)잔"
        calendarDetailView.deadBottleLabel.text = "\(maxBottles)병"
        calendarDetailView.deadGlassLabel.text = "\(maxGlasses)잔"
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
    
    private func setAction() {
        calendarDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
            return drinkDetails.count
        } else if tableView == calendarDetailView.hangoverTableView {
            return hangoverDetails.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == calendarDetailView.alcoholTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarAlcoholTableViewCell.identifier, for: indexPath) as? CalendarAlcoholTableViewCell else {
                return UITableViewCell()
            }
            let item = drinkDetails[indexPath.row]
            cell.alcoholLabel.text = "\(item.itemName)"
            cell.intakeLabel.text = "\(item.value)\(item.unit)"
            return cell
        } else if tableView == calendarDetailView.hangoverTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarHangoverTableViewCell.identifier, for: indexPath) as? CalendarHangoverTableViewCell else {
                return UITableViewCell()
            }
            let item = hangoverDetails[indexPath.row]
            cell.hangoverLabel.text = item.imageUrl
            cell.hangoverImage.sd_setImage(with: URL(string: item.hangoverName), placeholderImage: UIImage(named: "placeholder"))
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
