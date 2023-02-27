//
//  LoginViewModel.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject {
    
    private let authService = AuthService()
    
    @Published var phone: String = ""
    @Published var password: String = ""
    
    @Published var fieldErrors = (phone: "", password: "")
    
    @Published var showToast = false
    @Published var toastMessage: String = ""
    
    func errorHandling(apiError: APIError){
        if let message = apiError.getError.0 {
            self.toastMessage = message
            self.showToast = true
        }
        if let details = apiError.getError.1 {
            for item in details {
                if item.loc.count > 1 {
                    print("\(item.loc[1]) \(item.msg)")
                    switch item.loc[1] {
                    case "phone":
                        self.fieldErrors.phone = item.msg
                    case "password":
                        self.fieldErrors.password = item.msg
                    default:
                        print("-----")
                    }
                } else if !item.loc.isEmpty {
                    print(item)
                }
                
            }
        }
    }
    
    
    
    
}
