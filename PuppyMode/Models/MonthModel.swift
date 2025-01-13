//
//  monthModel.swift
//  PuppyMode
//
//  Created by 김미주 on 14/01/2025.
//

import Foundation

struct MonthModel {
    let month: String
}

extension MonthModel {
    static func dummy() -> [MonthModel] {
        return [
            MonthModel(month: "1월"),
            MonthModel(month: "2월"),
            MonthModel(month: "3월"),
            MonthModel(month: "4월"),
            MonthModel(month: "5월"),
            MonthModel(month: "6월"),
            MonthModel(month: "7월"),
            MonthModel(month: "8월"),
            MonthModel(month: "9월"),
            MonthModel(month: "10월"),
            MonthModel(month: "11월"),
            MonthModel(month: "12월")
        ]
    }
}
