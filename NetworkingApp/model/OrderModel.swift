//
//  OrderModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

struct OrderModel: Codable {
    let id : Int
    let orderId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
    }
}
