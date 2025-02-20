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
    let result: StartAppointmentResult?
}

struct StartAppointmentResult: Codable {
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

struct GetAppointmentsResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: AppointmentsResult?
}

struct AppointmentsResult: Codable {
    let totalCount: Int
    let appointments: [Appointment]
}

struct Appointment: Codable {
    let appointmentId: Int
    let dateTime: String // 날짜 및 시간 (ISO8601 형식)
    let address: String
    let locationName: String
    let status: String   // scheduled, completed 등 상태 값
}

struct GetAppointmentStatusResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GetAppointmentStatusResult?
}

struct GetAppointmentStatusResult: Codable {
    let appointmentId: Int
    let address: String
    let locationName: String
    let appointmentStatus: String
    let isDrinking: Bool
    let startTime: String
}

struct CheckDrinkingStatusResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: DrinkingStatusResult?
}

struct DrinkingStatusResult: Codable {
    let appointmentId: Int
    let isDrinking: Bool
    let appointmentStatus: String
    let puppyName: String
    let drinkingHours: Int
    let drinkingImageUrls: [String] // 이미지 URL 배열 추가
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

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
}

// MARK: DrinkCapacity

struct DrinkCapacityResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: DrinkCapacityResult?
}

struct DrinkCapacityResult: Codable {
    let drinkItemId: Int
    let drinkItemName: String
    let imageUrl: String?
    let alcoholPercentage: Float
    let safetyValueBottle: Float
    let safetyValueGlass: Int
    let maxValueBottle: Int
    let maxValueGlass: Int
    let average: Float
}

struct NearestScheduledAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: NearestScheduledAppointmentResult?
}

struct NearestScheduledAppointmentResult: Codable {
    let appointmentId: Int
    let dateTime: String
    let address: String
    let status: String
}

struct DeleteAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
}

struct UpdateAppointmentResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UpdateAppointmentResult?
}

struct UpdateAppointmentResult: Codable {
    let appointmentId: Int
    let updatedTime: String
    let address: String
    let locationName: String
    let appointmentStatus: String
}

struct AppointmentStatusResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: AppointmentStatusResult?
}

struct AppointmentStatusResult: Codable {
    let appointmentId: Int
    let isDrinking: Bool
    let appointmentStatus: String
    let puppyName: String
    let drinkingHours: Int
    let drinkingImageUrls: [String]
}

struct NaverGeocodeResponse: Codable {
    struct Address: Codable {
        let roadAddress: String?
        let jibunAddress: String?
        let x: String // 경도 (Longitude)
        let y: String // 위도 (Latitude)
    }
    
    let addresses: [Address]
}

struct GetAllAppointmentsResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String?
    let result: GetAppointmentsResult?
}

struct GetAppointmentsResult: Codable {
    let totalCount: Int?
    let appointments: [SingleAppointment]?
}

struct SingleAppointment: Codable {
    let appointmentId: Int
    let dateTime: String // ISO 8601 형식 (예: "2025-02-14T00:32:18")
    let address: String
    let locationName: String
    let status: String // 예: "scheduled", "ONGOING"
}
