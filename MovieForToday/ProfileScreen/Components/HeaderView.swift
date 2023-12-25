//
//  HeaderView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/25/23.
//

import SwiftUI

struct HeaderView: View {
    var profileImage: String
    var name: String
    var mail: String
    
    var body: some View {
        HStack {
            Image(profileImage)
                .resizable()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                .frame(width: 54, height: 54)
                .padding(.leading, 16)
            VStack(alignment: .leading, spacing: 8)  {
                Text(name)
                    .font(Font.custom(CustomFont.montSemiBold, size: 16))
                    .foregroundStyle(.white)
                Text(verbatim: mail)
                    .font(Font.custom(CustomFont.montMedium, size: 14))
                    .foregroundColor(Color(TextColors.grey.rawValue))
            }
            .padding(.leading, 8)
            
            Button {
                print(#function)
            } label: {
                Image("editColor")
                    .scaledToFit()
                    .frame(width: 54, height: 54)
            }
            .padding(.leading, 16)
            Spacer()
        }
        .padding()
        .background(Color(PrimaryColor.softDark.rawValue))
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.4)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    HeaderView(profileImage: "margot", name: "Margot", mail: "margo@gmail.com")
}
