//
//  LogIn View.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct LogIn_View: View {
    @State var login: String
    @State var password: String
    @State var mail: String
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    CustomTextField(value: $login, titleBorder: "Login", offsetNameX: -130, offsetNameY: -28, placeHolder: "Enter your login")
                    CustomTextField(value: $password, titleBorder: "Password", offsetNameX: -118, offsetNameY: -28, placeHolder: "Enter your password")
                    
                    Spacer().frame(height: 170)
                    
                    NavigationLink(destination: {
                        Registration(fullName: "", login: "", password: "", mail: "")
                    }, label: {
                        Text("Registration")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .font(.custom(.montMedium, size: 16))
                            .background(.black)
                            .cornerRadius(32)
                            .padding(.horizontal, 16)
                    })
                    
                    CustomButton(text: "Login", color: Color(PrimaryColor.mint.rawValue), action: {print(#function)})
                        .padding(.horizontal, 16)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LogIn_View(login: "", password: "", mail: "")
}
