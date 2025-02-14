//
//  CalendarDetailResponse.swift
//  PuppyMode
//
//  Created by 김미주 on 14/02/2025.
//

import Foundation

struct CalendarDetailResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [CalendarDetail]
}

struct CalendarDetail: Codable {
    let drinkHistoryId: Int
    let drinkDate: String
    let drinkAmount: Int
    let drinkItems: [DrinkItem]
    let feed: Feed?
    let hangoverItems: [HangoverItem]?
}

struct DrinkItem: Codable {
    let itemName: String
    let unit: String
    let value: Int
    let safetyValue: Int
    let maxValue: Int
}

struct Feed: Codable {
    let feedingType: String
    let feedImageUrl: String
}

struct HangoverItem: Codable {
    let hangoverId: Int
    let hangoverName: String
    let imageUrl: String
}
