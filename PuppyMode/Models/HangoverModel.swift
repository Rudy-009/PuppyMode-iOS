//
//  HangoverModel.swift
//  PuppyMode
//
//  Created by 김미주 on 17/01/2025.
//

import Foundation

struct HangoverModel {
    let image: String
    let label: String
}

extension HangoverModel {
    static func dummy() -> [HangoverModel] {
        return [
            HangoverModel(image: "", label: "머리가 아파요"),
            HangoverModel(image: "", label: "토할 것 같아요"),
            HangoverModel(image: "", label: "근육이 아파요"),
            HangoverModel(image: "", label: "속이 아파요"),
            HangoverModel(image: "", label: "피곤해요"),
            HangoverModel(image: "", label: "목이 말라요")
        ]
    }
}
