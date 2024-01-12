//
//  Registration.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import SwiftUI

struct Registration: View {
    @Environment(\.presentationMode) var rootView
    @State var fullName: String = ""
    @StateObject var signInViewModel = SignInViewModel()
    @State var showAlert = false
    @State var shake = false
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: PrimaryColor.mainDark.rawValue) ?? .white]
            }
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.mainDark.rawValue))
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    CustomTextField(value: $fullName , titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                        .autocapitalization(.words)
                        .shake($shake) { }
                    
                    CustomTextField(value: $signInViewModel.email, titleBorder: "@mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .shake($shake) { }
                    
                    CustomTextField(value: $signInViewModel.password, titleBorder: "Password", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your password")
                        .autocapitalization(.none)
                        .shake($shake) { }
                    
                    Spacer()
                    
                    CustomButton(text: "Create account", color: Color.black, action: {
                        Task {
                            do {
                                try await signInViewModel.signUp()
                                showAlert = true
                                return
                            } catch {
                                print(error.localizedDescription)
                                shake = true
                            }
                        }
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("The account has been created. Please enter your username and password"),  dismissButton: .default(Text("Ok")) {
                            rootView.wrappedValue.dismiss()
                            showAlert = false
                        })
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                }
                
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    Registration()
}
