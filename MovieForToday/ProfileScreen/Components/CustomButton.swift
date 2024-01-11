//
//  Button.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var color: Color
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .font(.custom(.montMedium, size: 16))
                .background(color)
                .cornerRadius(32)
        }
    }
}

#Preview {
    CustomButton(text: "Login", color: Color(PrimaryColor.mint.rawValue), action: {
        print("Button pressed")
    })
}
