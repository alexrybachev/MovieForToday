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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.customMain)
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customMain
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    CustomTextField(value: $fullName , titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                        .autocapitalization(.words)
                    
                    CustomTextField(value: $signInViewModel.email, titleBorder: "@mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    CustomTextField(value: $signInViewModel.password, titleBorder: "Password", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your password")
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    CustomButton(text: "Create account", color: Color.black, action: {
                        Task {
                            do {
                                try await signInViewModel.signUp()
                                showAlert = true
                                return
                            } catch {
                                print(error.localizedDescription)
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
