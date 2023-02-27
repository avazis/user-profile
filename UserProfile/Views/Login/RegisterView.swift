//
//  RegisterView.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI
import AlertToast

struct RegisterView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var authManager: AuthManager
    
    @StateObject private var viewModel = RegisterViewModel()
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    func save(){
        viewModel.createUser { user in
            authManager.login(userResponce: user, pswd: viewModel.password)
        }
    }
    
    var body: some View {
        ZStack{
            Color.white
            ScrollView{
                VStack{
                    VStack (alignment: .leading){
                        Text("Sign Up")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 19))
                            .foregroundColor(Color("green"))
                        ImageButton(photo: $viewModel.photo)
                        Spacer().frame(height: 20)
                        TextFieldView(label: "Phone number", text: $viewModel.phone, errorText: $viewModel.fieldErrors.phone)
                            .keyboardType(.phonePad)
                        PasswordTextFieldView(label: "Password", text: $viewModel.password, errorText: $viewModel.fieldErrors.password)
                        TextFieldView(label: "Name", text: $viewModel.name, errorText: $viewModel.fieldErrors.name)
                        TextFieldView(label: "Email", text: $viewModel.email, errorText: $viewModel.fieldErrors.email)
                            .keyboardType(.emailAddress)
                        HStack{
                            VStack(alignment: .trailing){
                                DatePicker("Birthday", selection: $viewModel.selectedDate, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                if !viewModel.fieldErrors.birthday.isEmpty {
                                    Text(viewModel.fieldErrors.birthday)
                                        .foregroundColor(Color.red)
                                        .font(.system(size: 10))
                                }
                            }
                        }
                    }
                    .padding()
                    VStack(alignment: .center){
                        Button("Sign Up") {
                            self.save()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background( Color("green"))
                        .cornerRadius(12)
                        
                        Button("Log In") {
                            self.presentation.wrappedValue.dismiss()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(Color.blue)
                        .padding()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                }
                .toast(isPresenting: $viewModel.showToast){
                    AlertToast(displayMode: .banner(.slide), type: .regular, title: viewModel.toastMessage)
                }
                .onTapGesture {
                    self.endEditing()
                }
            }
            if viewModel.showLoading {
                LoadingV()
            }
        }.navigationBarHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authManager: AuthManager())
            .preferredColorScheme(.dark)
    }
}
