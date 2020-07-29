//
//  MainViewModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation

class MainViewModel: ObservableObject, MainViewModelInput, MainViewModelOutput {
    let viewRouter : ViewRouter
    let userPref: UserPreferences
    
    init(viewRouter: ViewRouter, userPref: UserPreferences) {
        self.viewRouter = viewRouter
        self.userPref = userPref
    }
    
    func logout() {
        viewRouter.currentPage = "login"
        self.userPref.setValue(value: "", forKey: UserPreferences.Key.token)
    }
}

protocol MainViewModelInput {
    func logout()
}

protocol MainViewModelOutput {
    
}
