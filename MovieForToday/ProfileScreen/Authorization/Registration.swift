//
//  Registration.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import SwiftUI

struct Registration: View {
    @State var fullName: String
    @State var login: String
    @State var password: String
    @State var mail: String
    let firebase = FirebaseManager()
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 30) {
                    CustomTextField(value: $fullName, titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                    
                    CustomTextField(value: $login, titleBorder: "Login", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your login")
                    
                    CustomTextField(value: $mail, titleBorder: "@mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                    
                    CustomSecureField(value: $password, titleBorder: "Password", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your password")
                    
                    Spacer()
                
                    CustomButton(text: "Create account", color: Color.black, action: {
                        firebase.registrationUser(user: UserData(login: login, password: password, name: fullName, email: mail))
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                }
                .padding(.top, 200)
            }
        }
    }
}

#Preview {
    Registration(fullName: "", login: "", password: "", mail: "")
}
