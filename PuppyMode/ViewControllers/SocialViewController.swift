//
//  SocialViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit

class SocialViewController: UIViewController {
    
    private lazy var socialView = SocialView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = socialView
        socialView.rankingTableView.delegate = self
        socialView.rankingTableView.dataSource = self
        setupAction()
    }
    
    private func setupAction() {
        socialView.segmentView.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }
    
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            
        } else {
            
        }
    }

}

extension SocialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DummyRankModel.allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = DummyRankModel.allData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RankingTableViewCell.identifier,
            for: indexPath) as? RankingTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(index: indexPath.row, rankCell: data)
        if indexPath.row < 3 {
            cell.addTrophyComponent(rank: Rank(rawValue: indexPath.row + 1) ?? Rank.first)
        }
        return cell
    }
    
}

#Preview{
    SocialViewController()
}

