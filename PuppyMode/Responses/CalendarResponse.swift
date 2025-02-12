//
//  CalendarResponse.swift
//  PuppyMode
//
//  Created by 김미주 on 13/02/2025.
//

import Foundation

struct CalendarResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [DrinkRecord]
}

struct DrinkRecord: Codable {
    let drinkDate: String
    let status: String
    let drinkHistoryId: Int?
    let historyStatus: String?
    let appointmentId: Int?
    let appointmentTime: String?
}
