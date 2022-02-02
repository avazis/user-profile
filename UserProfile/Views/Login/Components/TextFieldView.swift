//
//  TextFieldView.swift
//  UserProfile
//
//  Created by Avazbek I. on 2/1/22.
//

import SwiftUI

struct TextFieldView: View {
    
    var label: String
    @Binding var text: String
    @Binding var errorText: String
    
    var body: some View {
        VStack {
            TextField(label, text: $text, onEditingChanged: { (changed) in
                $errorText.wrappedValue = ""
            })
                .preferredColorScheme(.light)
                .padding(12)
                .background(Color("lightGray"))
                .foregroundColor(Color("textBlack"))
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke($errorText.wrappedValue != ""  ? Color.red : Color("lightGray"), lineWidth: 2)
                )
            if $errorText.wrappedValue != "" {
                Text($errorText.wrappedValue)
                    .foregroundColor(Color.red)
                    .font(.system(size: 10))
            }
        }
    }
}


struct PasswordTextFieldView: View {
    
    var label: String
    @Binding var text: String
    @Binding var errorText: String
    
    var body: some View {
        VStack {
            SecureField(label, text: $text)
                .preferredColorScheme(.light)
                .padding(12)
                .background(Color("lightGray"))
                .foregroundColor(Color("textBlack"))
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke($errorText.wrappedValue != "" ? Color.red : Color("lightGray"), lineWidth: 2)
                )
                .onTapGesture {
                    $errorText.wrappedValue = ""
                }
            if !$errorText.wrappedValue.isEmpty {
                Text($errorText.wrappedValue)
                    .foregroundColor(Color.red)
                    .font(.system(size: 10))
            }
        }
    }
}


