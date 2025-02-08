//
//  SocialViewController.swift
//  PuppyMode
//
//  Created by 김미주 on 07/01/2025.
//

import UIKit
import KakaoSDKTalk

class SocialViewController: UIViewController {
    
    private var socialView = SocialView()
    private var rankDataToShow: [RankUserInfo] = RankModel.globalRankData
    private var throttleWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = socialView
        setupTableView()
        setupAction()
        requestToCallFriendsInfo()
        loadInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func setupTableView() {
        socialView.rankingTableView.delegate = self
        socialView.rankingTableView.dataSource = self
    }
    
    private func loadInitialData() {
        SocialService.fetchGlobalRankData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshData()
            }
        }
        SocialService.fetchFriendRankData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshData()
            }
        }
    }
    
    private func refreshData() {
        rankDataToShow = RankModel.currentState == .global
            ? RankModel.globalRankData
            : RankModel.friendsRankData
        if let myCell = RankModel.myGlobalRank {
            socialView.myRankView.configure(rankCell: myCell)
            socialView.myRankView.markMyRank()
        }
        socialView.rankingTableView.reloadData()
    }
    
    private func requestToCallFriendsInfo() {
        TalkApi.shared.friends { (friends, error) in
            if let _ = error {
                print("Not allowed to call friends")
            } else {
                print("Allowed to call friends")
                print("Friends Array 01 \(RankModel.friendsRankData)")
                SocialService.fetchFriendRankData {
                    DispatchQueue.main.async {
                        print("fetching friend rank data is over")
                        print("Friends Array 02 \(RankModel.friendsRankData)")
                        self.rankDataToShow = RankModel.friendsRankData
                        self.refreshData()
                        self.socialView.rankingTableView.reloadData()
                        print("Friends Array 03 \(RankModel.friendsRankData)")
                    }
                }
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
            requestToCallFriendsInfo()
            socialView.removeMyRankView()
        }
        refreshData()
        socialView.myRankView.configure(rankCell: RankModel.myGlobalRank!)
        socialView.myRankView.markMyRank()
        socialView.rankingTableView.reloadData()
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
        
        switch RankModel.currentState { // Change background to figure my rank
        case .global :
            if let rank = RankModel.myGlobalRank?.rank {
                if rank == data.rank && RankModel.myGlobalRank?.username == data.username {
                    cell.markMyRank()
                }
            }
        case .friends :
            if let rank = RankModel.myRankInFriends?.rank {
                if rank == data.rank {
                    cell.markMyRank()
                }
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            // 기존의 work item이 있다면 취소
            throttleWorkItem?.cancel()
            
            // 새로운 work item 생성, 0.3초(조절 가능) 후 실행
            throttleWorkItem = DispatchWorkItem { [weak self] in
                switch RankModel.currentState {
                case .global:
                    SocialService.fetchGlobalRankData()
                case .friends:
                    SocialService.fetchFriendRankData()
                }
                self?.socialView.rankingTableView.reloadData()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: throttleWorkItem!)
        }
    }
    
}
