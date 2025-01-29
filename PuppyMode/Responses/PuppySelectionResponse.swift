//
//  PuppySelectionResponse.swift
//  PuppyMode
//
//  Created by 이승준 on 1/28/25.
//

import Foundation

struct PuppySelectionResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PuppyTypeResponse
}

struct PuppyTypeResponse: Codable {
    let userId: Int
    let puppyType: String
    let puppyImageUrl: URL
}

struct PuppyDeletionResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}
