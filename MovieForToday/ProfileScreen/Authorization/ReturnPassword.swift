//
//  ReturnPassword.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/4/24.
//

import SwiftUI

struct ReturnPassword: View {
    @Environment(\.presentationMode) var rootView
    @State private var showAlert = false
    @StateObject var signInViewModel = SignInViewModel()
    @State var mail: String
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    CustomTextField(value: $mail, titleBorder: "@mail", offsetNameX: -130, offsetNameY: -28, placeHolder: "Enter your mail")
                        .padding(.bottom, 16)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    Spacer()
                    
                    Button(action: {
                        Task {
                            do {
                                try await FirebaseManager.shared.resetPassword(email: mail)
                                showAlert = true
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        Text("Send")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .font(.custom(.montMedium, size: 16))
                            .background(Color(PrimaryColor.mint.rawValue))
                            .cornerRadius(32)
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal, 16)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("The recover message was send to \(mail)"),  dismissButton: .default(Text("Ok")) {
                            showAlert = false
                            rootView.wrappedValue.dismiss()
                        })
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    ReturnPassword(mail: "")
}
