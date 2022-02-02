//
//  AuthService.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import Combine

class AuthService: APIRequest {
    
    func checkAPIError(response: Data) -> APIError{
        do {
            let missing: ErrorMissing? = try JSONDecoder().decode(ErrorMissing.self, from: response)
            return .missingError(details: missing?.detail ?? [])
        } catch{}
        do {
            let notAuth: ErrorDetail? = try JSONDecoder().decode(ErrorDetail.self, from: response)
            return .notAuthenticated(details: notAuth?.detail ?? "")
        } catch{}
        
        if let utf8Text = String(data: response, encoding: .utf8) {
            return .unknownError(details: utf8Text)
        }
        return .unknownError(details: response.debugDescription)
    }
    
    func auth(api: AppAPI,
              onSuccess successCallback: @escaping (_ response: UserResponse) -> Void,
              onFailure failureCallback: @escaping (_ errorMessage: APIError) -> Void) {
        request(api: api) { response in 
            do {
                let decoded: UserResponse? = try JSONDecoder().decode(UserResponse.self, from: response)
                successCallback(decoded!)
            } catch {
                failureCallback(self.checkAPIError(response: response))
            }
        } onFailure: { error in
            failureCallback(self.checkAPIError(response: error))
        }
    }
    
    func getMe(api: AppAPI,
               onSuccess successCallback: @escaping (_ response: UserResponse) -> Void,
               onFailure failureCallback: @escaping (_ errorMessage: APIError) -> Void) {
        requestWithoutParameter(api: api) { response in
            do {
                let decoded: UserResponse? = try JSONDecoder().decode(UserResponse.self, from: response)
                successCallback(decoded!)
            } catch {
                failureCallback(self.checkAPIError(response: response))
            }
        } onFailure: { error in
            failureCallback(self.checkAPIError(response: error))
        }
    }
    
    func login(api: AppAPI,
               onSuccess successCallback: @escaping (_ response: Token) -> Void,
               onFailure failureCallback: @escaping (_ errorMessage: APIError) -> Void) {
        requestMultipart(api: api) { response in
            do {
                let decoded: Token? = try JSONDecoder().decode(Token.self, from: response)
                successCallback(decoded!)
            } catch {
                failureCallback(self.checkAPIError(response: response))
            }
        } onFailure: { error in
            failureCallback(self.checkAPIError(response: error))
        }
    }
    
    
}

