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

struct NotificationPostBody: Codable {
    let token: String
    let title: String
    let body: String
    let image: String?
}

struct NotificationPostResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: NotificationResult?
}

struct NotificationResult: Codable {
    let validateOnly: Bool
    let message: MessageContent
}

struct MessageContent: Codable {
    let notification: NotificationContent
    let token: String
}

struct NotificationContent: Codable {
    let title: String
    let body: String
    let image: String?
}
