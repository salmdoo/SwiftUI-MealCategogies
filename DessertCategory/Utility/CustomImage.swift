//
//  CustomImag.swift
//  DessertCategory
//
//  Created by Salmdo on 11/10/23.
//

import SwiftUI

struct CustomImage: View {
    var url: String
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { img in
            img.resizable()
                .scaledToFit()
        } placeholder: {
            Image(systemName: "photo")
        }.clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            })
            .shadow(radius: 5)
    }
}

struct CustomImag_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage(url: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", maxWidth: 150, maxHeight: 150)
    }
}
