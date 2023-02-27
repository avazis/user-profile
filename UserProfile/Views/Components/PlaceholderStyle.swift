//
//  PlaceholderStyle.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color("darkGray"))
                
            }
            content
            .foregroundColor(Color.white)
            .padding(5.0)
        }
    }
}



