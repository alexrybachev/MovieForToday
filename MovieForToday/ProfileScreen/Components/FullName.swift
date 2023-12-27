//
//  FullName.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct FullName: View {
    @State var name: String
    var body: some View {
        TextField("Enter your name", text: $name)
            .padding(.leading, 16)
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(name.isEmpty ? Color(PrimaryColor.mint.rawValue) : Color.gray, lineWidth: 1.0)
                    .opacity(0.3)
                Text("Full Name")
                    .foregroundStyle(.white)
                    .font(.custom(.montMedium, size: 12))
                    .offset(x: -130, y: -28)
                
            }
            .padding(.horizontal, 16)
    }
}

#Preview {
    FullName(name: "Margot")
}
