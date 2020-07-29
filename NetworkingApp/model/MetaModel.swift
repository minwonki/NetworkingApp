//
//  MetaModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

struct MetaModel: Codable {
    let latestVersion: String
    let forceUpdate: Bool
    
    enum CodingKeys: String, CodingKey {
        case latestVersion = "latest_version"
        case forceUpdate = "force_update"
    }
}
