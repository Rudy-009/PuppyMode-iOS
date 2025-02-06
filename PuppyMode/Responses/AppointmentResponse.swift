//
//  AppointmentResponse.swift
//  PuppyMode
//
//  Created by 박준석 on 1/31/25.
//

import Foundation

struct StartAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: AppointmentResult?
}

struct AppointmentResult: Codable {
    let appointmentId: Int
    let address: String
    let locationName: String
    let appointmentStatus: String
    let isDrinking: Bool
    let startTime: String
}

struct EndAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: EndAppointmentResult?
}

struct EndAppointmentResult: Codable {
    let completedTime: String
    let appointmentStatus: String
}

struct GetAppointmentStatusResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: AppointmentStatusResult?
}

struct AppointmentStatusResult: Codable {
    let appointmentId: Int
    let isDrinking: Bool
    let appointmentStatus: String
}

struct RescheduleAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RescheduleResult?
}

struct RescheduleResult: Codable {
    let appointmentId: Int
    let rescheduledTime: String
    let message: String
}

struct CreateAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CreateAppointmentResult?
}

struct CreateAppointmentResult: Codable {
    let appointmentId: Int
    let dateTime: String
    let address: String
    let status: String
}
