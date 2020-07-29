//
//  SplashViewModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

class SplashViewModel: ObservableObject, SplashViewModelInput, SplashViewModelOutput {

    let userPref: UserPreferences
    let viewRouter: ViewRouter
    
    init(userPref: UserPreferences, viewRouter: ViewRouter) {
        self.userPref = userPref
        self.viewRouter = viewRouter
    }
    
    func checkToken() {
        if ((self.userPref.getStringValue(forKey: UserPreferences.Key.token)?.count ?? 0) > 0) {
            viewRouter.currentPage = "main"
        } else {
            viewRouter.currentPage = "login"
        }
    }
}

protocol SplashViewModelInput {
    func checkToken()
}

protocol SplashViewModelOutput {
    
}
