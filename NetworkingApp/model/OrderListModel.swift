//
//  OrderListModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

struct OrderListModel: Codable {
    let currentPage: Int
    let data: [OrderModel]
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
    }
}
