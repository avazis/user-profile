//
//  LoginView.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI
import AlertToast

struct LoginView: View {
    
    @ObservedObject var authManager: AuthManager
    
    @StateObject private var viewModel = LoginViewModel()
    
    func login(){
        authManager.login(phone: viewModel.phone, password: viewModel.password) { apiError in
            viewModel.errorHandling(apiError: apiError)
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white
                ScrollView{
                    VStack{
                        VStack (alignment: .leading){
                            Spacer().frame(height: 50)
                            Text("Sign In")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 19))
                                .foregroundColor(Color("green"))
                            Spacer().frame(height: 20)
                            TextFieldView(label: "Phone number", text: $viewModel.phone, errorText: $viewModel.fieldErrors.phone)
                                .keyboardType(.phonePad)
                            PasswordTextFieldView(label: "Password", text: $viewModel.password, errorText: $viewModel.fieldErrors.password)
                        }
                        .padding()
                        VStack(alignment: .center){
                            Button("Sign In") {
                                self.login()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background( Color("green"))
                            .cornerRadius(12)
                            NavigationLink {
                                RegisterView(authManager: authManager)
                            } label: {
                                Text("Sign Up")
                                    .frame(maxWidth: .infinity, maxHeight: 40)
                                    .foregroundColor(Color.blue)
                                    .padding()
                            }
                            
                            
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                    }
                    .toast(isPresenting: $viewModel.showToast){
                        AlertToast(displayMode: .banner(.slide), type: .regular, title: viewModel.toastMessage)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authManager: AuthManager())
            .preferredColorScheme(.light)
    }
}


