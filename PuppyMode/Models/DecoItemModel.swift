//
//  DecorationItemModel.swift
//  PuppyMode
//
//  Created by 김민지 on 1/19/25.
//

import UIKit
import Foundation

// 아이템 카테고리
struct itemKey {
    struct String {
        static let tags = ["모자", "옷", "바닥", "집", "장난감"]
    }
}

// 강아지 레벨
enum DogLevel {
    case level1, level2, level3
}

struct DecoItemModel {
    let image: UIImage?
    let price: String
}


extension DecoItemModel {
    // 모자
    static let hatData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "머리 위에 무지개"), price: ""),
        DecoItemModel(image: UIImage(named: "머리 위에 별 하나"), price: ""),
        DecoItemModel(image: UIImage(named: "머리 위에 별 세개"), price: ""),
        DecoItemModel(image: UIImage(named: "돌 모자"), price: ""),
        DecoItemModel(image: UIImage(named: "판다 머리띠"), price: "")
    ]
    
    // 옷
    static let clothesData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "붕대"), price: ""),
        DecoItemModel(image: UIImage(named: "밴드"), price: ""),
        DecoItemModel(image: UIImage(named: "이불"), price: ""),
        DecoItemModel(image: UIImage(named: "명품 강아지 옷"), price: "500P"),
        DecoItemModel(image: UIImage(named: "하늘색 체크 옷"), price: "300P")

    ]
    
    // 바닥
    static let floorData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "별 다섯개 짜리 돌침대"), price: ""),
        DecoItemModel(image: UIImage(named: "좌변기"), price: ""),
        DecoItemModel(image: UIImage(named: "핑크 집"), price: ""),
        DecoItemModel(image: UIImage(named: "산타 집"), price: "1500P"),
        DecoItemModel(image: UIImage(named: "텐트"), price: "1500P"),
        DecoItemModel(image: UIImage(named: "박스"), price: "")

    ]
    
    // 집
    static let houseData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "무지개 카페트"), price: ""),
        DecoItemModel(image: UIImage(named: "무지개 바다"), price: ""),
        DecoItemModel(image: UIImage(named: "코타츠"), price: "1000P"),
        DecoItemModel(image: UIImage(named: "코타츠2"), price: "1000P"),
        DecoItemModel(image: UIImage(named: "귀여운 러그"), price: "1000P"),
        DecoItemModel(image: UIImage(named: "정수기 생수통"), price: "")
    ]
    
    // 장난감
    static let toyData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "두루마리 휴지"), price: ""),
        DecoItemModel(image: UIImage(named: "소화제"), price: ""),
        DecoItemModel(image: UIImage(named: "링거"), price: ""),
        DecoItemModel(image: UIImage(named: "소주병"), price: ""),
        DecoItemModel(image: UIImage(named: "1.5L 생수병"), price: "")
    ]
}
