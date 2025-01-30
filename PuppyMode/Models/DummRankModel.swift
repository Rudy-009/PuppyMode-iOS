//
//  DummyRankModel.swift
//  PuppyMode
//
//  Created by 이승준 on 1/21/25.
//

import UIKit

class DummyRankModel {
    
    static let allData: [RankCell] = [
        RankCell(name: "김민준", characterName: "골든리트리버", characterLevel: 3),
        RankCell(name: "이서연", characterName: "비숑프리제", characterLevel: 4),
        RankCell(name: "박지훈", characterName: "포메라니안", characterLevel: 2),
        RankCell(name: "최수아", characterName: "시바견", characterLevel: 5),
        RankCell(name: "정도현", characterName: "웰시코기", characterLevel: 3),
        RankCell(name: "케빈", characterName: "말티즈", characterLevel: 1),
        RankCell(name: "윤서준", characterName: "치와와", characterLevel: 4),
        RankCell(name: "임지아", characterName: "푸들", characterLevel: 2),
        RankCell(name: "한유진", characterName: "시츄", characterLevel: 5),
        RankCell(name: "송민서", characterName: "닥스훈트", characterLevel: 3),
        RankCell(name: "오지원", characterName: "허스키", characterLevel: 4),
        RankCell(name: "신예준", characterName: "진돗개", characterLevel: 2),
        RankCell(name: "황서윤", characterName: "불독", characterLevel: 5),
        RankCell(name: "조현우", characterName: "사모예드", characterLevel: 1),
        RankCell(name: "백수민", characterName: "비글", characterLevel: 3),
        RankCell(name: "류하린", characterName: "달마시안", characterLevel: 4),
        RankCell(name: "남도윤", characterName: "차우차우", characterLevel: 2),
        RankCell(name: "문서현", characterName: "보더콜리", characterLevel: 5),
        RankCell(name: "Me", characterName: "요크셔테리어", characterLevel: 3),
        RankCell(name: "안지유", characterName: "래브라도리트리버", characterLevel: 1),
    ]
    
    static let friendData: [RankCell] = [
        RankCell(name: "오지원", characterName: "허스키", characterLevel: 4),
        RankCell(name: "신예준", characterName: "진돗개", characterLevel: 2),
        RankCell(name: "황서윤", characterName: "불독", characterLevel: 5),
        RankCell(name: "조현우", characterName: "사모예드", characterLevel: 1),
        RankCell(name: "백수민", characterName: "비글", characterLevel: 3),
        RankCell(name: "류하린", characterName: "달마시안", characterLevel: 4),
        RankCell(name: "남도윤", characterName: "차우차우", characterLevel: 2),
        RankCell(name: "문서현", characterName: "보더콜리", characterLevel: 5),
        RankCell(name: "Me", characterName: "요크셔테리어", characterLevel: 3),
        RankCell(name: "안지유", characterName: "래브라도리트리버", characterLevel: 1),
        RankCell(name: "김민준", characterName: "골든리트리버", characterLevel: 3),
        RankCell(name: "이서연", characterName: "비숑프리제", characterLevel: 4),
        RankCell(name: "박지훈", characterName: "포메라니안", characterLevel: 2),
        RankCell(name: "최수아", characterName: "시바견", characterLevel: 5),
        RankCell(name: "정도현", characterName: "웰시코기", characterLevel: 3),
        RankCell(name: "강하은", characterName: "말티즈", characterLevel: 1),
        RankCell(name: "윤서준", characterName: "치와와", characterLevel: 4),
        RankCell(name: "임지아", characterName: "푸들", characterLevel: 2),
        RankCell(name: "한유진", characterName: "시츄", characterLevel: 5),
        RankCell(name: "송민서", characterName: "닥스훈트", characterLevel: 3),
    ]
}

struct RankCell {
    var name: String
    var characterName: String
    var characterLevel: Int
}
