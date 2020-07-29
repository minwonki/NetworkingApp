//
//  BaseAPI.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/27.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import Moya

protocol BaseService: TargetType {}

extension BaseService {
    var baseURL: URL {
        URL(string: "https://api.test-spot.com/api/v1")!
    }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task { .requestPlain }
    
    var defaultHeaders: [String : String] {
        var httpHeaders = [
            "X-Longtail-Client":"1",
            "Content-Type":"application/json",
            "Accept":"application/json",
        ]
        let userPref = container.resolve(UserPreferences.self)!
        let token = userPref.getStringValue(forKey: UserPreferences.Key.token) ?? ""
        if token.count > 0 {
            httpHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return httpHeaders
    }
    
    var headers: [String: String]? {
        return defaultHeaders
    }
    
}
