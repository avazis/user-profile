//
//  AuthManager.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import Combine
import UIKit

enum PageState {
    case loading
    case loginView
    case main(user: UserResponse)
}

final class AuthManager: ObservableObject {
    
    private let authService = AuthService()
    
    static var accessToken: String?
    
    static var deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    @Published var pageState: PageState = .loginView
    
    static let accessTokenKey = "AccessToken"
    
    let defaults = UserDefaults.standard
    
    init() {
        if let at = defaults.string(forKey: Self.accessTokenKey){
            Self.accessToken = at
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: Self.accessTokenKey)
        pageState = .loginView
    }
    
    func login(userResponce: UserResponse, pswd: String){
        login(phone: userResponce.phone, password: pswd) { apiError in }
    }
    
    func login(token: Token, failed:  @escaping (_ apiError: APIError) -> Void){
        AuthManager.accessToken = "\(token.tokenType) \(token.accessToken)"
        
        // Save token
        defaults.set(Self.accessToken, forKey: Self.accessTokenKey)
        
        // Fetch current user me
        fetchUser(){ err in
            failed(err)
        }
    }
    
    
    func login(phone: String, password: String, failed:  @escaping (_ apiError: APIError) -> Void ){
        
        authService.login(api: .login(params: ["username": phone, "password": password])) { response in
            self.login(token: response){ err in
                failed(err)
            }
        } onFailure: { errorMessage in
            failed(errorMessage)
        }
    }
    
    func fetchUser(failed:  @escaping (_ apiError: APIError) -> Void) {
        
        if Self.accessToken != nil {
            authService.getMe(api: .getUser) { response in
                self.pageState = .main(user: response)
            } onFailure: { errorMessage in
                self.pageState = .loginView
                failed(errorMessage)
            }
        } else {
            print("AccessToken not found")
            self.pageState = .loginView
        }
        
    }
    
}
