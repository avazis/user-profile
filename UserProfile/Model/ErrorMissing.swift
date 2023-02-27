//
//  ErrorMissing.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation

// MARK: - ErrorObj
struct ErrorMissing: Codable {
    let detail: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
    let loc: [String]
    let msg, type: String
}

// MARK: - ErrorDetail
struct ErrorDetail: Codable {
    let detail: String
}
