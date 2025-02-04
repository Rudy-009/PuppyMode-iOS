//
//  SocialViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import KakaoSDKTalk

class SocialViewController: UIViewController {
    
    private lazy var socialView = SocialView()
    private var rankDataToShow: [UserRankInfo] = RankModel.globalRankData

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = socialView
        socialView.rankingTableView.delegate = self
        socialView.rankingTableView.dataSource = self
        setupAction()
        callFreiends()
    }
    
    private func callFreiends() {
        TalkApi.shared.friends { (friends, error) in
            if let error = error {
                print(error)
            } else {
                
            }
        }
    }
    
    private func setupAction() {
        socialView.segmentView.addTarget(self, action: #selector(segmentedControlValueChanged(segment:)), for: .valueChanged)
    }
    
    @objc
    private func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            RankModel.currentState = .global
            rankDataToShow = RankModel.globalRankData
            socialView.addMyRankView()
        } else {
            RankModel.currentState = .friends
            rankDataToShow = RankModel.friendsRankData
            socialView.removeMyRankView()
        }
        socialView.myRankView.configure(rankCell: RankModel.myGlobalRank!)
        socialView.myRankView.markMyRank()
        socialView.rankingTableView.reloadData()
    }
    
    public func configureMyRankCell() {
        socialView.myRankView.configure(rankCell: RankModel.myGlobalRank!)
    }

}

extension SocialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankDataToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = rankDataToShow[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RankingTableViewCell.identifier,
            for: indexPath) as? RankingTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(rankCell: data)
        
        if indexPath.row < 3 { // Trophy 이미지 추가
            cell.addTrophyComponent(rank: Rank(rawValue: indexPath.row + 1) ?? Rank.first)
        }
        
        if RankModel.currentState == .global { // Change background to figure my rank
            if let rank = RankModel.myGlobalRank?.rank {
                if rank == data.rank {
                    cell.markMyRank()
                }
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y            // 현재 화면의 아래 y 좌표
        let contentHeight = scrollView.contentSize.height   // 컨텐츠의 전체 길이
        let height = scrollView.frame.size.height           // 
        
        if offsetY > contentHeight - height {
            SocialService.fetchGlobalRankData()
            socialView.rankingTableView.reloadData()
        }
    }
    
}
