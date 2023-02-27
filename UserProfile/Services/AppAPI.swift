//
//  AppAPI.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import Alamofire
//import UIKit


protocol APIProtocol {
    var base: String { get }
    var path: String { get }
    var query: [String:String]? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

enum AppAPI {
    case regUser(params: [String:String])
    case login(params: [String:String])
    case getUser
}
extension AppAPI: APIProtocol {
    
    var base: String {
        return "https://testtask.softorium.pro"
    }
    
    var path: String {
        switch self {
        case .regUser: return base+"/signup"
        case .login: return base+"/signin"
        case .getUser: return base+"/users/me/"
        }
    }
    
    var query: [String:String]? {
        switch self {
        case .regUser(let params), .login(let params):
            return params
        default:
            return nil
        }
    }
    
    
    
    var method: HTTPMethod {
        switch self {
        case  .regUser, .login: return .post
        case .getUser: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            
        case .regUser:
            return [
                "Content-type": "application/json",
                "X-APP-ID": AuthManager.deviceID
            ]
        case .login:
            return [
                "Content-type": "multipart/form-data",
                "X-APP-ID": AuthManager.deviceID
            ]
        case .getUser:
            if let token = AuthManager.accessToken {
                return [
                    "Content-type": "application/json",
                    "Authorization": token,
                    "X-APP-ID": AuthManager.deviceID
                ]
            }
            return nil
            
            
        }
    }
    
}

