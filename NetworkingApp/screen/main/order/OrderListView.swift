//
//  OrderListView.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: OrderListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.orders, id: \.id) { order in
                Text("order:\(order.id)")
            }
        }
        .onAppear(){
            log.info("onApperar OrderListView")
            self.viewModel.getOrders()
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(viewModel: OrderListViewModel(orderRepository: TestOrderRepository()))
    }
}
