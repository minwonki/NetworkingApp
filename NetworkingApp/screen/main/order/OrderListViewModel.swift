//
//  OrderListViewModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import RxSwift

class OrderListViewModel : ObservableObject, OrderListViewModelInput, OrderListViewModelOutput  {
    let disposeBag = DisposeBag()
    
    @Published var orders: [OrderModel] = []
    
    func getOrdersStub() {
        self.orders = [OrderModel(id: 1, orderId: 1),
                       OrderModel(id: 2, orderId: 2),
                       OrderModel(id: 3, orderId: 2)]
    }
    
    func getOrders() {
        orderRepository.getOrders()
            .subscribe { event in
            switch event {
            case let .success(model):
                log.info("Model:", model)
                log.info("Data:", model.data)
                self.orders = model.data
                
            case let .error(error):
                log.error("Error:", error)
            }
        }.disposed(by: disposeBag)
    }
    
    let orderRepository : OrderRepository
    
    init(orderRepository: OrderRepository) {
        self.orderRepository = orderRepository
    }
    
}

protocol OrderListViewModelInput {
    func getOrders()
}

protocol OrderListViewModelOutput {
    var orders: [OrderModel] { get }
}
