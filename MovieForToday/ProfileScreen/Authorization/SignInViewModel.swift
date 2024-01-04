//
//  SignInViewModel.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/30/23.
//

import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
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
    
//    func resetPassword() async throws {
//        let authUser = try FirebaseManager.shared.getAuthenticatedUser()
//        guard let email = authUser.email else {
//            throw URLError(.fileDoesNotExist)
//        }
//        try await FirebaseManager.shared.resetPassword(email: email)
//    }
    
    
}
