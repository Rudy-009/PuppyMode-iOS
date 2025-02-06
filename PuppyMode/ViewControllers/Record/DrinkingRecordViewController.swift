//
//  DrinkingViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit
import Alamofire

class DrinkingRecordViewController: UIViewController {
    private let drinkingView = DrinkingRecordView()
    private var addedItems: [DrankAlcoholModel] = []
    private var hangoverOptions: [Int]
    
    init(hangoverOptions: [Int]) {
        self.hangoverOptions = hangoverOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = drinkingView
        drinkingView.tableView.register(DrankAlcoholTableViewCell.self, forCellReuseIdentifier: "AlcoholCell")
        drinkingView.tableView.dataSource = self
        drinkingView.tableView.delegate = self
        
        drinkingView.tableView.separatorStyle = .none
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        drinkingView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        drinkingView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        drinkingView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    func addNewItem(_ item: DrankAlcoholModel) {
        print("📌 새로운 아이템 추가: \(item.name), \(item.sliderValue) \(item.unit)")
        addedItems.append(item)

        DispatchQueue.main.async {
            self.drinkingView.tableView.reloadData()
            self.drinkingView.updateTableViewHeight()
        }
    }

    
    // MARK: - action
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func plusButtonTapped() {
        let alcoholVC = AlcoholViewController()
        
        // Pass a closure to handle the selected alcohol item
        alcoholVC.onAlcoholSelected = { [weak self] selectedItem in
            guard let self = self else { return }
            
            // Navigate to IntakeViewController with the selected alcohol information
            let intakeVC = IntakeViewController(
                alcoholName: selectedItem.name,
                alcoholImage: UIImage(named: selectedItem.image), // Use the image property from the model
                drinkCategoryId: selectedItem.drinkCategoryId,
                drinkItemId: selectedItem.drinkItemId
            )
            
            intakeVC.onItemAdded = { newItem in
                // Add the new item to the list and reload the table view
                self.addedItems.append(newItem)
                self.drinkingView.tableView.reloadData()
                
                // Update the table view's height dynamically
                self.drinkingView.updateTableViewHeight()
            }
            
            self.navigationController?.pushViewController(intakeVC, animated: true)
        }
        
        navigationController?.pushViewController(alcoholVC, animated: true)
    }

    
    
    @objc
    private func completeButtonTapped() {
        print("✅ 음주 기록 완료 버튼 클릭됨")
        
        let alcoholTolerance = addedItems.map { item in
            return [
                "drinkCategoryId": item.drinkCategoryId,
                "drinkItemId": item.drinkItemId,
                "value": item.sliderValue,
                "unit": item.unit
            ]
        }
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let drinkDate = dateFormatter.string(from: yesterday)
        
        let parameters: [String: Any] = [
            "drinkDate": drinkDate,
            "hangoverOptions": hangoverOptions,
            "alcoholTolerance": alcoholTolerance
        ]
        
        guard let jwt = KeychainService.get(key: UserInfoKey.jwt.rawValue) else {
            print("JWT Token not found")
            return
        }
        
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(jwt)",
            "Content-Type": "application/json"
        ]
        
        let url = "https://puppy-mode.site/drinks/record"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("✅ 요청 성공: \(data)")
                    
                    // API 응답을 파싱하고 처리
                    if let json = data as? [String: Any],
                       let result = json["result"] as? [String: Any],
                       let message = result["message"] as? String {
                        print("✅ 서버 메시지: \(message)")
                    }
                    
                    // 성공 시 다음 화면으로 이동
                    let recordCompleteVC = RecordCompleteViewController()
                    self.navigationController?.pushViewController(recordCompleteVC, animated: true)
                    
                case .failure(let error):
                    print("❌ 요청 실패: \(error.localizedDescription)")
                }
            }
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        print(rowIndex)
        
        // Remove item from data source
        addedItems.remove(at: rowIndex)
        
        // Update table view with animation
        drinkingView.tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        
        // Update table view height dynamically if needed
        drinkingView.updateTableViewHeight()
    }

}

// MARK: - extension
extension DrinkingRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlcoholCell", for: indexPath) as? DrankAlcoholTableViewCell else {
            return UITableViewCell()
        }
        
        let item = addedItems[indexPath.row]
        
        // Configure the cell with data from DrankAlcoholModel
        cell.alcoholImageView.image = UIImage(named: "soju_bottle") // Replace with actual image logic if needed
        cell.alcoholNameLabel.text = item.name // Alcohol name from model
        cell.sliderValueLabel.text = "\(item.sliderValue) \(item.isBottleMode ? "병" : "잔")" // Quantity and mode
        
        // Handle delete button action
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115 // Adjust row height as needed
    }
}
