//
//  AlcoholDetailModel.swift
//  PuppyMode
//
//  Created by 김미주 on 24/01/2025.
//

import Foundation

struct AlcoholDetailModel {
    let image: String
    let name: String
    let volume: String
    let degree: String
    let kind: String
}

extension AlcoholDetailModel {
    static func dummy() -> [AlcoholDetailModel] {
        return [
            AlcoholDetailModel(image: "soju_fresh", name: "참이슬 후레쉬", volume: "360", degree: "16", kind: "소주"),
            AlcoholDetailModel(image: "soju_original", name: "참이슬 오리지널", volume: "500", degree: "20.1", kind: "소주"),
            AlcoholDetailModel(image: "jinro_iz_back", name: "진로 이즈백", volume: "360", degree: "16", kind: "소주"),
            AlcoholDetailModel(image: "cheoeum_cheoreom", name: "처음처럼", volume: "500", degree: "16.5", kind: "소주"),
            AlcoholDetailModel(image: "saero", name: "새로", volume: "360", degree: "16", kind: "소주"),
            AlcoholDetailModel(image: "cass", name: "카스", volume: "500", degree: "4.5", kind: "맥주"),
            AlcoholDetailModel(image: "terra", name: "테라", volume: "500", degree: "4.6", kind: "맥주"),
            AlcoholDetailModel(image: "kelly", name: "켈리", volume: "500", degree: "4.5", kind: "맥주"),
            AlcoholDetailModel(image: "hanmac", name: "한맥", volume: "500", degree: "4.6", kind: "맥주"),
            AlcoholDetailModel(image: "kloud", name: "클라우드", volume: "500", degree: "5", kind: "맥주"),
            AlcoholDetailModel(image: "crush_beer", name: "크러시", volume: "500", degree: "4.5", kind: "맥주"),
        ]
    }
}
