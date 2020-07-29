//
//  ErrorModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/27.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

struct LSError : Codable, Error {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    init(error: Error) {
        self.message = error.localizedDescription
    }
}
