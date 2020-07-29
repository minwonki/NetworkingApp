//
//  OrderRepository.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol OrderRepository {
    func getOrders() -> Single<OrderListModel>
}

class OrderRepositoryImpl: OrderRepository {
    
    let provider : NetworkProvider<OrderService>
    
    init(provider: NetworkProvider<OrderService>) {
        self.provider = provider
    }
    
    func getOrders() -> Single<OrderListModel> {
        return provider.request(target: .orders(userId: "41375"))
            .map(OrderListModel.self)
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

class TestOrderRepository: OrderRepository {
    func getOrders() -> Single<OrderListModel> {
        return Single.just(
            OrderListModel(currentPage: 1,
                           data: [OrderModel(id: 1, orderId: 1),
                                  OrderModel(id: 2, orderId: 2),
                                  OrderModel(id: 2, orderId: 2)]))
    }
}

enum OrderService {
    case orders(userId: String)
}

extension OrderService: BaseService {
    var path: String {
        switch self {
        case let .orders(userId):
            return "/drivers/\(userId)/orders"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .orders:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .orders(_):
            return .requestParameters(
                parameters: [
                    "page": 1,
                    "start_date": "2020-04-22",
                    "end_date": "2020-06-10",
                    "order_receipt": 1,
                    "invoice_received_time": 1
                ],
                encoding: URLEncoding.queryString)
        }
    }
}
