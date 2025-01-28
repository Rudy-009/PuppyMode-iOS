//
//  DrinkingViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 22/01/2025.
//

import UIKit

class DrinkingRecordViewController: UIViewController {
    private let drinkingView = DrinkingRecordView()
    private var addedItems: [DrankAlcoholModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = drinkingView
        drinkingView.tableView.register(DrankAlcoholTableViewCell.self, forCellReuseIdentifier: "AlcoholCell")
        drinkingView.tableView.dataSource = self
        drinkingView.tableView.delegate = self
        
        drinkingView.tableView.separatorStyle = .none // Remove default separators
        
        setAction()
    }
    
    // MARK: - function
    private func setAction() {
        drinkingView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        drinkingView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        drinkingView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
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
                alcoholImage: UIImage(named: selectedItem.image) // Use the image property from the model
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
        let recordCompleteVC = RecordCompleteViewController()
        navigationController?.pushViewController(recordCompleteVC, animated: true)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        
        // Remove item from data source
        addedItems.remove(at: rowIndex)
        
        // Update table view with animation
        drinkingView.tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        
        // Update table view height dynamically if needed
        drinkingView.updateTableViewHeight()
    }

}

// MARK: - UITableViewDataSource
extension DrinkingRecordViewController: UITableViewDataSource {
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
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Add spacing by adjusting the cell's content inset
        let marginSpace: CGFloat = 10
        
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: marginSpace / 2,
                                                                               left: marginSpace,
                                                                               bottom: marginSpace / 2,
                                                                               right: marginSpace))
        
        // Optional shadow effect for floating appearance
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.masksToBounds = false // Ensure shadow is visible outside bounds
        
        // Ensure corner radius is applied properly
        if let customCell = cell as? DrankAlcoholTableViewCell {
            customCell.contentView.layer.cornerRadius = 10
            customCell.contentView.layer.masksToBounds = true
            customCell.layer.cornerRadius = 10
            customCell.layer.masksToBounds = false // Allow shadow outside bounds
        }
    }
}

// MARK: - UITableViewDelegate (Optional)
extension DrinkingRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95 // Adjust row height as needed
    }
}
