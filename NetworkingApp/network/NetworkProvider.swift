//
//  NetworkProvider.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/29.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import RxMoya
import Moya
import RxSwift

class NetworkProvider<API: TargetType> {
    private let provider = MoyaProvider<API>(plugins: [ReqeustLoggingPlugin()])
    lazy var rx = provider.rx
    
    func request(target: API) -> Single<Response> {
        return rx.request(target)
            .filterSuccessfulStatusCodes()
            .catchError { error in
                let moyaError = error as? MoyaError
                switch(moyaError) {
                case .statusCode(let response):
                    let testError = try JSONDecoder().decode(LSError.self, from: response.data)
                    // log tracking
                    return Single.error(testError)
                default:
                    // log tracking
                    let testError = LSError(error: error)
                    return Single.error(testError)
                }
        }
        .do()
    }
}
