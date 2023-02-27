//
//  LoadingV.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI


struct LoadingV: View {
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
                .opacity(0.8)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("green")))
                .scaleEffect(3)
        }
    }
    
}

