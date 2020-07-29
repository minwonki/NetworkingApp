//
//  TokenModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

struct TokenModel: Codable {
    let token: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case tokenType = "token_type"
    }
}
