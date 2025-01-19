//
//  DecorationItemModel.swift
//  PuppyMode
//
//  Created by 김민지 on 1/19/25.
//

import UIKit

struct DecorationItemModel {
    let image: UIImage?
    let title: String
}


extension DecorationItemModel {
    static let data: [DecorationItemModel] = [
        DecorationItemModel(image: UIImage(named: "deco_item1"), title: "300P"),
        DecorationItemModel(image: UIImage(named: "deco_item2"), title: "300P")
    ]
}
