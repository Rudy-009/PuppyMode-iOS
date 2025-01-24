//
//  Bundle.swift
//  PuppyMode
//
//  Created by 이승준 on 1/25/25.
//

import Foundation

extension Bundle {
    var kakaoAppKey: String? {
        return infoDictionary?[K.String.kakaoAppKey] as? String
    }
}
