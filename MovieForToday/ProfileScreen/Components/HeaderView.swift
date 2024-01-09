//
//  HeaderView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/25/23.
//

import SwiftUI

struct HeaderView: View {
    var profileImage: String?
    var name: String?
    var mail: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(!profileImage!.isEmpty ? profileImage! : "margot")
                .resizable()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                .frame(width: 54, height: 54)
                .padding(.leading, 16)
            VStack(alignment: .leading, spacing: 8)  {
                Text(name ?? "User")
                    .font(Font.custom(CustomFont.montSemiBold, size: 16))
                    .foregroundStyle(.white)

                Text(verbatim: mail)
                    .font(Font.custom(CustomFont.montMedium, size: 14))
                    .foregroundColor(Color(TextColors.grey.rawValue))
                 
            }
            .padding(.leading, 8)
            
            Spacer()
            
            NavigationLink(destination: EditProfile(profileImage: profileImage ?? "margot", name: name ?? "User", mail: mail)) {  Image("editColor")
                    .scaledToFit()
                    .frame(width: 54, height: 54)
            }
        }
        .padding()
        .background(Color(PrimaryColor.softDark.rawValue))
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.3)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    HeaderView(profileImage: "", name: "", mail: "")
}
