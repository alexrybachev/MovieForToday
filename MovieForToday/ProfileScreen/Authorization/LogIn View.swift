//
//  LogIn View.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct LogInView: View {
    @StateObject var viewModel = SignInViewModel()
    @Binding var showSignInView : Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    CustomTextField(value: $viewModel.email, titleBorder: "Login", offsetNameX: -130, offsetNameY: -28, placeHolder: "Enter your login")
                    CustomTextField(value: $viewModel.password, titleBorder: "Password", offsetNameX: -118, offsetNameY: -28, placeHolder: "Enter your password")
                    
                    Spacer().frame(height: 170)
                    
                    NavigationLink(destination: {
                        Registration(fullName: "", login: "", password: "", showSignInView: $showSignInView, mail: "")
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
                    
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signIn()
                                self.showSignInView = false
                                return
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        Text("LogIn")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .font(.custom(.montMedium, size: 16))
                            .background(Color(PrimaryColor.mint.rawValue))
                            .cornerRadius(32)
                    }
                    .padding(.horizontal, 16)
                }
                .padding()
            }
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    LogInView(showSignInView: .constant(false))
}
