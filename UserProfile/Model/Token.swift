//
//  Token.swift
//  UserProfile
//
//  Created by Avazbek I. on 2/1/22.
//

import Foundation

// MARK: - Token
struct Token: Codable {
    let accessToken, tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

