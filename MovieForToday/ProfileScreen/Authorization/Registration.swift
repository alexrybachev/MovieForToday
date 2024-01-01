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
    @StateObject var signInViewModel = SignInViewModel()
    @Binding var showSignInView: Bool
    @State var mail: String
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 30) {
                    CustomTextField(value: $fullName, titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                    
                    CustomTextField(value: $login, titleBorder: "Login", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your login")
                    
                    CustomTextField(value: $signInViewModel.email, titleBorder: "@mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                    
                    CustomSecureField(value: $signInViewModel.password, titleBorder: "Password", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your password")
                    
                    Spacer()
                
                    CustomButton(text: "Create account", color: Color.black, action: {
                        Task {
                            do {
                                try await signInViewModel.signUp()
                                self.showSignInView = false
                                return
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                }
                .padding(.top, 140)
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    Registration(fullName: "", login: "", password: "", showSignInView: .constant(false), mail: "")
}
