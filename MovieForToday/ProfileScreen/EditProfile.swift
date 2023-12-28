//
//  EditProfile.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/26/23.
//

import SwiftUI

struct EditProfile: View {
    var profileImage: String
    @State var name: String
    @State var mail: String
    
    var body: some View {
        VStack {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 16) {
                    Button {
                        print(#function)
                    } label: {
                        ZStack {
                            Image(profileImage)
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 74, height: 74)
                            Image("editProfileAvatar")
                                .offset(x: 20, y: 20)
                                .frame(width: 32, height: 32)
                        }
                    }
                    
                    Text(name)
                        .foregroundStyle(.white)
                        .font(.custom(.montSemiBold, size: 14))
                    
                    Text(verbatim: mail)
                        .foregroundStyle(.textGrey)
                        .font(.custom(.montMedium, size: 14))
                        .padding(.top, -8)
                    
                  
                    CustomTextField(value: $name, titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                        .padding(.top, 40)
                    CustomTextField(value: $mail, titleBorder: "@Mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    CustomButton(text: "Save changes", color: Color(PrimaryColor.mint.rawValue), action: {print(#function)})
                    .padding(.horizontal, 16)
                }
                .padding(.top, 20)
            }
            .foregroundColor(.white)
        }
        .navigationTitle("Edit Profile")
    }
}

#Preview {
    EditProfile(profileImage: "margot", name: "Margo", mail: "margo@gmail.com")
}
