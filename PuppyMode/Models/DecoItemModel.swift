//
//  DecorationItemModel.swift
//  PuppyMode
//
//  Created by 김민지 on 1/19/25.
//

import UIKit
import Foundation

struct itemKey {
    struct String {
        static let tags = ["모자", "옷", "바닥", "집", "장난감"]
    }
}

struct DecoItemModel {
    let image: UIImage?
    let title: String
}


extension DecoItemModel {
    // 모자
    static let hatData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "hat_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "hat_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "hat_item3"), title: "300P"),
        DecoItemModel(image: UIImage(named: "hat_item4"), title: "300P"),
        DecoItemModel(image: UIImage(named: "hat_item5"), title: "300P")
    ]
    
    // 옷
    static let clothesData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "clothes_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "clothes_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "clothes_item3"), title: "300P"),
        DecoItemModel(image: UIImage(named: "clothes_item4"), title: "300P"),
        DecoItemModel(image: UIImage(named: "clothes_item5"), title: "300P")

    ]
    
    // 바닥
    static let floorData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "floor_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "floor_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "floor_item3"), title: "300P"),
        DecoItemModel(image: UIImage(named: "floor_item4"), title: "300P"),
        DecoItemModel(image: UIImage(named: "floor_item5"), title: "300P"),
        DecoItemModel(image: UIImage(named: "floor_item6"), title: "300P")

    ]
    
    // 집
    static let houseData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "house_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "house_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "house_item3"), title: "300P"),
        DecoItemModel(image: UIImage(named: "house_item4"), title: "300P"),
        DecoItemModel(image: UIImage(named: "house_item5"), title: "300P"),
        DecoItemModel(image: UIImage(named: "house_item6"), title: "300P")
    ]
    
    // 장난감
    static let toyData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "toy_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "toy_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "toy_item3"), title: "300P"),
        DecoItemModel(image: UIImage(named: "toy_item4"), title: "300P"),
        DecoItemModel(image: UIImage(named: "toy_item5"), title: "300P")
    ]
}
