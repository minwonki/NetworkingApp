//
//  TestRepository.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/27.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol AccountRepository {
    func login(id: String, userType: Int) -> Single<TokenModel>
    func meta() -> Single<MetaModel>
}

class AccountRepositoryImpl: AccountRepository {
    let provider : NetworkProvider<AcountService>
    
    init(provider: NetworkProvider<AcountService>) {
        self.provider = provider
    }
    
    func login(id: String, userType: Int) -> Single<TokenModel> {
        return provider.request(target: .login(id:id, userType: userType))
            .map(TokenModel.self)
            .catchError { error in
                switch (error as? MoyaError) {
                case .objectMapping(let error, _):
                    return Single.error(LSError(error: error))
                default:
                    return Single.error(error)
                }
        }
    }
    
    func meta() -> Single<MetaModel> {
        return provider.request(target: .meta(version: "123"))
            .map(MetaModel.self)
            .catchError { error in
                switch (error as? MoyaError) {
                case .objectMapping(let error, _):
                    return Single.error(LSError(error: error))
                default:
                    return Single.error(error)
                }
        }
    }
}

enum AcountService {
    case login(id: String, userType: Int)
    case meta(version: String)
}

extension AcountService: BaseService {
    var path: String {
        switch self {
        case .login:
            return "/authentication/token"
        case .meta:
            return "/meta"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .meta:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .login(id, userType):
            return .requestParameters(
                parameters: [
                    "id": id,
                    "user_type": userType,
                    "password": ""
                ], encoding: JSONEncoding.default)
            
        case .meta(_):
            return .requestParameters(
                parameters: [
                    "app_type": "driver",
                    "version": "3.0.0",
                    "platform": "ios"
                ],
                encoding: URLEncoding.queryString)
        }
        
    }
    
}
