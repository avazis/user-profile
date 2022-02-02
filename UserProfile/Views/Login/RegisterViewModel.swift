//
//  RegisterViewModel.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import UIKit


class RegisterViewModel: ObservableObject {
    
    private let authService = AuthService()
    
    @Published var selectedDate = Date()
    
    @Published var photo: UIImage? = nil
    
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var birthday: String = ""
    
    @Published var showLoading: Bool = false
    
    @Published var fieldErrors = (phone: "", password: "", name: "", email: "", birthday: "")
    
    @Published var showToast = false
    @Published var toastMessage: String = ""
    
    
    func getParams() -> [String:String] {
        var params: [String:String] = [:]
        params["phone"] = phone
        params["password"] = password
        params["name"] = name
        params["email"] = email
        params["birthday"] = birthday
        if let _ = photo {
//            let data = photo.compress(to: 20)
//            let strBase64 = data.base64EncodedString()
//            params["avatar_img"] = strBase64
            
            
            
            /////
            

            let imageString = photo?.jpegData(compressionQuality: 0)?.base64EncodedString() ?? ""
//            let base64ImageString = "url('data:image/jpeg;base64,\(imageString)')"
                           
                      
            print("AAA")
            
            params["avatar_img"] = imageString
            print("BBB")
            
            ///////
        }
        if let timeZone = TimeZone.current.localizedName(for: .shortStandard, locale: Locale.current) {
            params["time_zone"] = timeZone
        }
        
        if dateToString(date: selectedDate) != dateToString(date: Date()) {
            params["birthday"] = dateToString(date: selectedDate)
        }
        
        return params
    }
    
    func createUser( complated:  @escaping (_ user: UserResponse) -> Void ){
        
//        let p = getParams()
//        print(p)
//        return
//        if let photo = photo {
//            let data = photo.compress(to: 20)
//            let strBase64 = data.base64EncodedString()
//            print(strBase64)
//        }
//        return
        var validated = true

        if phone.isEmpty {
            fieldErrors.phone = "Field is empty"
            validated = false
        }
        if password.isEmpty {
            fieldErrors.password = "Field is empty"
            validated = false
        }
        if name.isEmpty {
            fieldErrors.name = "Field is empty"
            validated = false
        }

        if !validated { return }

        showLoading = true
        authService.auth(api: .regUser(params: getParams())) { response in
            self.showLoading = false
            print(response.phone)
            complated(response)
        } onFailure: { errorMessage in
            self.showLoading = false
            print(errorMessage.getError.0 ?? "")
            if let message = errorMessage.getError.0 {
                self.toastMessage = message
                self.showToast = true
            }

            if let details = errorMessage.getError.1 {
                for item in details {
                    print("\(item.loc[1]) \(item.msg)")
                    switch item.loc[1] {
                    case "name":
                        self.fieldErrors.name = item.msg
                    case "phone":
                        self.fieldErrors.phone = item.msg
                    case "password":
                        self.fieldErrors.password = item.msg
                    case "birthday":
                        self.fieldErrors.birthday = item.msg
                    default:
                        print("-----")
                    }
                }
            }

        }
        
    }
    
}



