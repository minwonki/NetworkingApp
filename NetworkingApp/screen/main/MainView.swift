//
//  MainView.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView {
            VStack {
                Text("Hello, MainView!")
                Button(action: {
                    self.viewModel.logout()
                }) {
                    Text("Logout")
                }
            }.tabItem {
                Image(systemName: "phone.fill")
                Text("First")
            }.onAppear(){
                log.info("1 View")
            }
            
            VStack{
                Text("Hello, Second")
            }.tabItem {
                Image(systemName: "tv.fill")
                Text("Second")
            }.onAppear(){
                log.info("2 View")
            }
            
            OrderListView(viewModel: container.resolve(OrderListViewModel.self)!)
            .tabItem {
                Image(systemName: "car.fill")
                Text("Third")
            }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: container.resolve(MainViewModel.self)!)
    }
}
