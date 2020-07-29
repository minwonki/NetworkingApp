//
//  LoginView.swift
//  NetworkingApp
//
//  Created by WONKI MIN on 2020/07/28.
//  Copyright © 2020 WONKI MIN. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            TextField("Enter your phone number:", text: $viewModel.id )
                .padding()
            Button(action: {
                self.viewModel.login(name: self.viewModel.id)
            }) {
                Text("Login")
            }
            Button(action:{
                self.viewModel.meta()
            }) {
                Text("Meta")
            }
            Text("\(viewModel.url)")
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Notice"),
                  message: Text("\(viewModel.errorMessage)"),
                  dismissButton: .default(Text("확인")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: container.resolve(LoginViewModel.self)!)
    }
}
