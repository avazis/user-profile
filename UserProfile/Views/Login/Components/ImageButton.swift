//
//  ImageButton.swift
//  UserProfile
//
//  Created by Avazbek I. on 1/31/22.
//

import SwiftUI

struct ImageButton: View {
    
    @Binding var photo: UIImage?
    @State private var image: Image? = Image("btn_photo")
    @State private var shouldPresentImagePicker = false
    
    var body: some View {
        Button(action: {
            self.shouldPresentImagePicker = true
        }) {
            HStack{
                Spacer()
                
                if let resultImage = photo {
                    Image(uiImage: resultImage)
                        .resizable()
                        .frame(width: 93, height:93)
                        .cornerRadius(46.5)
                } else {
                    image?
                        .resizable()
                        .frame(width: 93, height:93)
                        .cornerRadius(46.5)
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $shouldPresentImagePicker) {
            ImagePicker(sourceType: .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker, uiimage: $photo)
        }
    }
}


