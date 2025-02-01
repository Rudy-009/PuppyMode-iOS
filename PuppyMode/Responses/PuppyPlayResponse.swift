//
//  PuppyPlayResponse.swift
//  PuppyMode
//
//  Created by 김민지 on 2/1/25.
//

import Foundation

struct PuppyPlayResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result : PuppyPlayResult?
}

struct PuppyPlayResult: Decodable {
    let level: Int
    let levelMinExp: Int
    let levelMaxExp: Int
    let puppyExp: Int
}
