//
//  SignInViewModel.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/30/23.
//

import Foundation
import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let uderData = try await FirebaseManager.shared.createUser(email: email, password: password)
        print("Success")
        print(uderData)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let uderData = try await FirebaseManager.shared.signInUser(email: email, password: password)
        print("Success")
        print(uderData)
    }
    
//    func signInListener() -> Bool {
//        FirebaseManager.shared.signInListener { auth, user in
//            if user != nil {
//              showSignInView = false
//            }
//        }
//    }
 
}
