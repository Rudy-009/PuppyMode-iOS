//
//  DummyRankModel.swift
//  PuppyMode
//
//  Created by 이승준 on 1/21/25.
//

import UIKit

class RankModel {
    
    static var currentState: SocialState = .global
    static var myGlobalRank: UserRankInfo?
    
    static var globalRankData: [UserRankInfo] = []
    
    static var friendsRankData: [UserRankInfo] = []
    
    enum SocialState {
        case global, friends
    }
}
