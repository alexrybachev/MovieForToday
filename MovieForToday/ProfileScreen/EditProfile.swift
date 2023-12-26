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
                    
                   
                    

                    TextField("Change your name", text: $name)
                        .padding(.leading, 16)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(name.isEmpty ? Color.red : Color.gray, lineWidth: 1.0)
                                .opacity(0.3)
                            Text("Full Name")
                                .foregroundStyle(.white)
                                .font(.custom(.montMedium, size: 12))
                                .offset(x: -130, y: -28)
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 40)
                                        
                    TextField("Change your @mail", text: $mail)
                        .padding(.leading, 16)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(mail.isEmpty ? Color.red : Color.gray, lineWidth: 1.0)
                                .opacity(0.3)
                            Text("Email")
                                .foregroundStyle(.white)
                                .font(.custom(.montMedium, size: 12))
                                .offset(x: -142, y: -28)
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Button {
                        print(#function)
                    } label: {
                        Text("Save Changes")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .font(.custom(.montMedium, size: 16))
                            .background(Color(PrimaryColor.mint.rawValue))
                            .cornerRadius(32)
                        
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 20)
            }
        }
        .navigationTitle("Edit Profile")
    }
}

#Preview {
    EditProfile(profileImage: "margot", name: "Margo", mail: "margo@gmail.com")
}
