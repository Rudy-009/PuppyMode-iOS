//
//  NotificationResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 1/28/25.
//

import Foundation

struct NotificationsResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReceiveNotificationsResponse
}

struct ReceiveNotificationsResponse: Codable {
    let receiveNotifications: Bool
}
