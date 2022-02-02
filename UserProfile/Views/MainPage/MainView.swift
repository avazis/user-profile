//
//  MainView.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authManager: AuthManager
    
    var user: UserResponse
    
    var body: some View {
        ZStack{
            Color.white
            VStack(alignment: .leading, spacing: 20){
                
                VStack(alignment: .center){
                    Text("Main Page")
                        .fontWeight(.bold)
                    Spacer().frame(height: 20)
                    AsyncImage(url: URL(string: user.avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        Color("lightGray")
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }.frame(maxWidth: .infinity)
                    .padding()
                HStack{
                    Text("Name: ")
                    Text(user.name)
                        .fontWeight(.bold)
                }
                HStack{
                    Text("Phone: ")
                    Text(user.phone)
                        .fontWeight(.bold)
                }
                HStack{
                    Text("Email: ")
                    Text(user.email)
                        .fontWeight(.bold)
                }
                HStack{
                    Text("Birthday: ")
                    Text(user.birthday)
                        .fontWeight(.bold)
                }
                HStack{
                    Text("Time zone: ")
                    Text(user.timeZone)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .center){
                    Button("Log Out") {
                        authManager.logout()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(Color.blue)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
            }.padding(40)
                .foregroundColor(Color("textBlack"))
        }
        
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authManager: AuthManager(), user: UserResponse(id: "", name: "", phone: "", email: "", avatar: "", birthday: "", dtCreate: "", enabled: true, timeZone: ""))
    }
}
