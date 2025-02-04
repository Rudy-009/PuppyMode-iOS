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
    private var rankDataToShow: [UserRankInfo] = RankModel.globalRankData
    private var throttleWorkItem: DispatchWorkItem?

    override func viewWillAppear(_ animated: Bool) { // 뷰가 나타나기 전에 데이터 fetch와 UI 갱신 처리
        super.viewWillAppear(animated)
        SocialService.fetchGlobalRankData {
            self.socialView.rankingTableView.reloadData()
            self.socialView.myRankView.configure(rankCell: RankModel.myGlobalRank!)
            self.socialView.myRankView.markMyRank()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.view = socialView
        socialView.rankingTableView.delegate = self
        socialView.rankingTableView.dataSource = self
        setupAction()
        requestToCallFriendsInfo()
    }
    
    private func requestToCallFriendsInfo() {
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
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
                
        if offsetY > contentHeight - height {
            // 기존의 work item이 있다면 취소
            throttleWorkItem?.cancel()
            
            // 새로운 work item 생성, 0.3초(조절 가능) 후 실행
            throttleWorkItem = DispatchWorkItem { [weak self] in
                SocialService.fetchGlobalRankData()
                self?.socialView.rankingTableView.reloadData()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: throttleWorkItem!)
        }
    }
    
}
