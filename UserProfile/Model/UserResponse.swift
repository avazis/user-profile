//
//  UserResponse.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let id, name, phone, email: String
       let avatar: String
       let birthday: String
       let dtCreate: String
       let enabled: Bool
       let timeZone: String

       enum CodingKeys: String, CodingKey {
           case id, name, phone, email, avatar, birthday
           case dtCreate = "dt_create"
           case enabled
           case timeZone = "time_zone"
       }
}


