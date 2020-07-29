//
//  TestViewModel.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/27.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel : ObservableObject, LoginViewModelProtocol {
    private let disposeBag = DisposeBag()
   
    // Input
    @Published var id: String = ""
    
    // Output
    @Published var url: String = ""
    @Published var showAlert: Bool = false
    var errorMessage: String = ""
    
    let accountRepository: AccountRepository
    let viewRouter: ViewRouter
    let userPref: UserPreferences
    
    init(accountRepository: AccountRepository, viewRouter: ViewRouter, userPref: UserPreferences) {
        self.accountRepository = accountRepository
        self.viewRouter = viewRouter
        self.userPref = userPref
    }
    
    func login(name: String) {
        accountRepository.login(id: name, userType: 3)
            .subscribe { event in
                switch event {
                case let .success(model):
                    self.url = model.token
                    self.userPref.setValue(value: model.token, forKey: UserPreferences.Key.token)
                    self.viewRouter.currentPage = "main"
                    
                case let .error(error):
                    self.showAlert = true
                    self.errorMessage = (error as? LSError)?.message ?? "unknow error"
                }

        }.disposed(by: disposeBag)
    }
    
      func meta() {
          accountRepository.meta()
              .subscribe { event in
                  switch event {
                  case let .success(model):
                      self.url = model.latestVersion
                    
                  case let .error(error):
                      self.showAlert = true
                      self.errorMessage = (error as? LSError)?.message ?? "unknow error"
                  }

          }.disposed(by: disposeBag)
      }
}

protocol LoginViewModelProtocol: TestViewModelInput, TestViewModelOutput {
}

protocol TestViewModelInput {
    var id: String { get }
    func login(name: String)
}

protocol TestViewModelOutput {
    var url: String { get }
    var errorMessage: String { get }
    var showAlert: Bool { get }
}
