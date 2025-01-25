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
        static let tags = ["모자", "얼굴", "옷", "집", "바닥", "장난감"]
    }
}

struct DecoItemModel {
    let image: UIImage?
    let title: String
}


extension DecoItemModel {
    // 모자
    static let hatData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "deco_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "deco_item2"), title: "300P"),
        DecoItemModel(image: UIImage(named: "deco_item2"), title: "300P")
    ]
    
    // 얼굴
    static let faceData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "deco_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "deco_item2"), title: "300P")
    ]
    
    // 옷
    static let clothData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "deco_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "deco_item2"), title: "300P")
    ]
    
    // 집
    static let houseData: [DecoItemModel] = [
        DecoItemModel(image: UIImage(named: "deco_item1"), title: "300P"),
        DecoItemModel(image: UIImage(named: "deco_item2"), title: "300P")
    ]
}
