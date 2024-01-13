//
//  CustomSecureField.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import SwiftUI

struct CustomSecureField: View {
    
    @Binding var value: String
    var titleBorder: String
    var offsetNameX: CGFloat
    var offsetNameY: CGFloat
    var placeHolder: String
    var body: some View {
        
        SecureField(placeHolder, text: $value)
            .padding(.leading, 16)
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(value.isEmpty ? Color(PrimaryColor.mint.rawValue) : Color.gray, lineWidth: 1.0)
                        .opacity(0.3)
                    Text(titleBorder)
                        .foregroundStyle(.white)
                        .font(.custom(.montMedium, size: 12))
                        .offset(x: offsetNameX, y: offsetNameY)
                }
            }
            .padding(.horizontal, 16)
    }
}



#Preview {
    CustomSecureField(value: .constant(""), titleBorder: "", offsetNameX: -130, offsetNameY: -28, placeHolder: "")
}
