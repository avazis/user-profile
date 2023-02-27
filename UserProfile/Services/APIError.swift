//
//  APIError.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation

enum APIError: Error {
    case notAuthenticated(details: String)
    case unknownError(details: String)
    case missingError(details: [Detail])
    var getError: (String?, [Detail]?) {
        switch self {
        case .notAuthenticated(let d), .unknownError(let d):
            return (d, nil)
        case .missingError(let d):
            return (nil, d)
        }
    }
}
