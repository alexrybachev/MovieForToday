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
    @Published var currentUser: UserData?
    @Published var savedUser: SaveUser?
    @Published var showNotification = false
    @Published var profileImage: UIImage?
    @State var errorMessage: ErrorMessage?
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage?.error = "No email or password found"
            print("No email or password found.")
            return
        }
        
        let uderData = try await FirebaseManager.shared.createUser(email: email, password: password)
        print("Success")
        print(uderData)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage?.error = "No email or password found"
            print("No email or password found.")
            return
        }
        currentUser = try await FirebaseManager.shared.signInUser(email: email, password: password)
        print("Success")
    }
    
    func fetchUser() async throws  {
        do {
            self.currentUser = try FirebaseManager.shared.getAuthenticatedUser()
            try await FirebaseManager.shared.getUserData(userId: currentUser?.uid ?? "" )
        } catch let error {
            self.errorMessage?.error = error.localizedDescription
            throw error
        }
    }
    
//    func signInListener() -> Bool {
//        FirebaseManager.shared.signInListener { auth, user in
//            if user != nil {
//              showSignInView = false
//            }
//        }
//    }
 
}
