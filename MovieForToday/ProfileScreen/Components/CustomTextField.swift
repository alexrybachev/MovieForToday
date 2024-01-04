//
//  FullName.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI


struct CustomTextField: View {
    
    @Binding var value: String
    var titleBorder: String
    var offsetNameX: CGFloat
    var offsetNameY: CGFloat
    var placeHolder: String
    var body: some View {

        TextField(placeHolder, text: $value)
            .padding(.leading, 16)
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .disableAutocorrection(true)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(value.isEmpty ? Color(PrimaryColor.mint.rawValue) : Color.gray, lineWidth: 1.0)
                    .opacity(0.3)
                Text(titleBorder)
                    .foregroundStyle(.white)
                    .font(.custom(.montMedium, size: 12))
                    .offset(x: offsetNameX, y: offsetNameY)
                
            }
            .padding(.horizontal, 16)
    }
    
}

#Preview {
    CustomTextField(value: .constant("Value"), titleBorder: "Your name", offsetNameX: -130, offsetNameY: -28, placeHolder: "Enter your name")
}
