//
//  LogIn View.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @Environment(\.presentationMode) var rootView
    @StateObject var viewModel = SignInViewModel()
    @ObservedObject var errorMessage = ErrorMessage()
    @Binding var showSignInView: Bool
    @Binding var isAuthorisation: Bool
    @State var shake = false
    @State private var error = ""
    
    init(showSignInView: Binding<Bool>, isAuthorisation: Binding<Bool>) {
        self._showSignInView = showSignInView
        self._isAuthorisation = isAuthorisation
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.customMain)]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customMain
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    CustomTextField(value: $viewModel.email, titleBorder: "Login", offsetNameX: -130, offsetNameY: -28, placeHolder: "Enter your mail")
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .shake($shake) { }
                    
                    CustomSecureField(value: $viewModel.password, titleBorder: "Password", offsetNameX: -118, offsetNameY: -28, placeHolder: "Enter your password")
                        .autocapitalization(.none)
                        .shake($shake) { }
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            ReturnPassword()
                        } label: {
                            Text("forgot password?")
                                .font(.custom(.montMedium, size: 14))
                        }
                        .offset(y: -10)
                        .padding(.top, 0)
                        .padding(.trailing, 20)
                    }
                    
//                    HStack {
//                        Text(errorMessage.error ?? "")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 40)
//                            .font(.system(size: 20))
//                            .foregroundColor(.red)
//                            .padding()
//                    }
                    
                    Spacer()
                    
                    Button {
                        rootView.wrappedValue.dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                    
                    
                    NavigationLink(destination: {
                        Registration()
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
                                if Auth.auth().currentUser != nil {
                                    self.showSignInView = false
                                    isAuthorisation = true
                                }
                                return
                            } catch {
                                print(error)
                                shake = true
                            }
                        }
                    }) {
                        Text("LogIn")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .font(.custom(.montMedium, size: 16))
                            .background(Color.customMint)
                            .cornerRadius(32)
                    }
                    .padding(.horizontal, 16)
                }
                .padding()
            }
            //        .onChange(of: showSignInView) { showSignInView in
            //            if !showSignInView {
            //                Task {
            //                    do {
            //                        try? await viewModel.fetchUser()
            //                    }
            //                }
            //            }
            //        }
            
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    LogInView(showSignInView: .constant(false), isAuthorisation: .constant(false))
}
