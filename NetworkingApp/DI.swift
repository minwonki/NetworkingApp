//
//  DI.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import Swinject

let container = Container {
    // Singleton, UserPreferences
    $0.register(UserPreferences.self) { _ in UserPreferences() }.inObjectScope(.container)
    
    // Singleton, ViewRouter
    $0.register(ViewRouter.self) { _ in ViewRouter() }.inObjectScope(.container)
    
    // Repository
    $0.register(AccountRepository.self) { _ in AccountRepositoryImpl(provider: NetworkProvider<AcountService>()) }
    $0.register(OrderRepository.self) { _ in OrderRepositoryImpl(provider: NetworkProvider<OrderService>()) }
    
    // ViewModel
    $0.register(SplashViewModel.self) { r in
        SplashViewModel(userPref: r.resolve(UserPreferences.self)!,
                        viewRouter: r.resolve(ViewRouter.self)!)
    }
    
    $0.register(LoginViewModel.self) { r in
        LoginViewModel(accountRepository: r.resolve(AccountRepository.self)!,
                       viewRouter: r.resolve(ViewRouter.self)!,
                       userPref: r.resolve(UserPreferences.self)!)
    }
    $0.register(MainViewModel.self) { r in
        MainViewModel(viewRouter: r.resolve(ViewRouter.self)!,
                      userPref: r.resolve(UserPreferences.self)!)
    }
    $0.register(OrderListViewModel.self) { r in
        OrderListViewModel(orderRepository: r.resolve(OrderRepository.self)!)
    }
    
    
}
