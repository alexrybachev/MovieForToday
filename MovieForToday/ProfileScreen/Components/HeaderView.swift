//
//  HeaderView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/25/23.
//

import SwiftUI

struct HeaderView: View {
    @State var profileImage: UIImage?
    @Binding var isAuthorisation: Bool
    var name: String?
    var mail: String
    
    var body: some View {
        HStack(alignment: .center) {
           image(image: profileImage)
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
                    .foregroundColor(Color.textGrey)
                 
            }
            .padding(.leading, 8)
            
            Spacer()
            
            if isAuthorisation {
                NavigationLink(destination: EditProfile(profileImage: $profileImage, name: name ?? "User", mail: mail)) {
                    Image("editColor")
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                }
            }
        }
        .padding()
        .background(Color.customMain)
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
    
    func image(image: UIImage?) -> Image {
        if let profileImage = image {
            return Image(uiImage: profileImage)
        } else {
            return  Image(uiImage: UIImage(named: "margot")!)
        }
    }
}

#Preview {
    HeaderView(profileImage: UIImage(named: "margo")!, isAuthorisation: .constant(false), name: "Margo", mail: "margo@gmail.com")
}
