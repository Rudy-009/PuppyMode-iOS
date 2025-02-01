//
//  CollectionResponse.swift
//  PuppyMode
//
//  Created by 김민지 on 2/1/25.
//

import Foundation

struct CollectionResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CollectionResult?
}

struct CollectionResult: Decodable {
    let userCollectionViewDTOs: [UserCollectionItem]
}

struct UserCollectionItem: Decodable {
    let userCollectionId: Int
    let collectionName: String
    let puppyItemId: Int
    let hangoverName: String
    let requiredNum: Int
    let currentNum: Int
    let completed: Bool
}
