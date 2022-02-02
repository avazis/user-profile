//
//  APIRequest.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

protocol APIRequest {}

extension APIRequest {
    
    func request(
        api: AppAPI,
        onSuccess successCallback: ((Data) -> Void)?,
        onFailure failureCallback: ((Data) -> Void)?
    ) {
        AF.request(api.path, method: api.method, parameters: api.query!, encoder: JSONParameterEncoder.default, headers: api.headers).validate().response { response in
            guard let status = response.response?.statusCode else { return }
            if let data = response.data {
                do {
                    let _ = try JSONDecoder().decode(ErrorDetail.self, from: data)
                    failureCallback?(data)
                    return
                } catch{}
            }
            if status >= 400 && status < 600 {
                if let data = response.data {
                    failureCallback?(data)
                    return
                }
            }
            switch response.result {
            case .success(let value):
                if let value = value {
                    successCallback?(value)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                failureCallback?(response.data ?? Data())
            }
        }
    }
    
    
    func requestMultipart(
        api: AppAPI,
        onSuccess successCallback: ((Data) -> Void)?,
        onFailure failureCallback: ((Data) -> Void)?
    ) {
        AF.upload(multipartFormData:  { (multipartFormData) in
            if let q = api.query {
                for (key, value) in q {
                    multipartFormData.append((value).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, to: api.path, method: api.method, headers: api.headers).response { response in
            guard let status = response.response?.statusCode else { return }
            if let data = response.data {
                do {
                    let _ = try JSONDecoder().decode(ErrorDetail.self, from: data)
                    failureCallback?(data)
                    return
                } catch{}
            }
            if status >= 400 && status < 600 {
                if let data = response.data {
                    failureCallback?(data)
                    return
                }
            }
            switch response.result {
            case .success(let value):
                if let value = value {
                    successCallback?(value)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestWithoutParameter(
        api: AppAPI,
        onSuccess successCallback: ((Data) -> Void)?,
        onFailure failureCallback: ((Data) -> Void)?
    ) {
        AF.request(api.path, method: api.method, headers: api.headers).validate().response { response in
            guard let status = response.response?.statusCode else { return }
            if let data = response.data {
                do {
                    let _ = try JSONDecoder().decode(ErrorDetail.self, from: data)
                    failureCallback?(data)
                    return
                } catch{}
            }
            if status >= 400 && status < 600 {
                if let data = response.data {
                    failureCallback?(data)
                    return
                }
            }
            switch response.result {
            case .success(let value):
                if let value = value {
                    successCallback?(value)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

