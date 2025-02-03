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
