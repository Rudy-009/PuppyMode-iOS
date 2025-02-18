//
//  PuppyItemResponse.swift
//  PuppyMode
//
//  Created by 김민지 on 2/3/25.
//

import Foundation

// 카테고리 조히
struct PuppyCategoryResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CategoryResult
}

struct CategoryResult: Decodable {
    let categories: [Category]
    let totalCount: Int
}

struct Category: Decodable {
    let categoryId: Int
    let name: String
    let itemCount: Int
}


// 카테고리 별 아이템 조회
struct PuppyItemResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ItemResult
}

struct ItemResult: Decodable {
    let totalCount: Int
    let items: [Item]
}

struct Item: Decodable {
    let itemId: Int
    let name: String
    let price: Int
    let image_url: String
    let isPurchased: Bool
    let mission_item: Bool
}


// 아이템 구매
struct PuppyPurchaseResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PuppyPurchaseResult?
}

struct PuppyPurchaseResult: Decodable {
    let itemId: Int
    let currentPoint: Int
}


// 소유한 아이템 조회
struct PuppyOwnedItemResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [PuppyOwnedItemResponseResult]?
}

struct PuppyOwnedItemResponseResult: Decodable {
    let itemId: Int
    let name: String
    let price: Int
    let image_url: String
    let isPurchased: Bool
    let mission_item: Bool
}


// 아이템 착용 / 해제
struct PuppyWearResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PuppyWearResult?
}

struct PuppyWearResult: Decodable {
    let itemId: Int
    let itemName: String
    let equippedImage: String
}


// 아이템 착용된 이미지
struct PuppyItemEquipImageResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [PuppyItemEquipImageResult]?
}

struct PuppyItemEquipImageResult: Decodable {
    let itemId: Int
    let itemName: String
    let equippedImage: String
}
