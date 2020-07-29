//
//  ContentView.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/24.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewRouter : ViewRouter
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "login" {
                LoginView(viewModel: container.resolve(LoginViewModel.self)!)
            } else {
                MainView(viewModel: container.resolve(MainViewModel.self)!)
            }
        }
        .onAppear(){
            self.viewModel.checkToken()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: container.resolve(ViewRouter.self)!,
                    viewModel: container.resolve(SplashViewModel.self)!)
    }
}
