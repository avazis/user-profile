//
//  UserProfileApp.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI

@main
struct UserProfileApp: App {
    
    
    @ObservedObject var authManager = AuthManager()
    
    init() {
        authManager.pageState = .loginView
//        authManager.fetchUser(){ err in
//            print(err)
//        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            switch authManager.pageState {
            case .loading:
                LoadingView()
            case .loginView:
                LoginView(authManager: authManager)
            case .main(let user):
                MainView(authManager: authManager, user: user)
            }
        }
    }
}
