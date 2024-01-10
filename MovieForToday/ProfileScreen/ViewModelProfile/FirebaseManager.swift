//
//  FirebaseManager.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import Foundation
import Firebase

struct UserData {
    let uid: String
    let login: String
    let name: String?
    let email: String
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.login = user.uid
        self.name = user.displayName
        self.email = user.email ?? "no mail"
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> UserData  {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return UserData.init(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> UserData {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserData(user: authData.user)
    }
    
    func signInUser(email: String, password: String) async throws -> UserData {
        let authDataResults = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserData(user: authDataResults.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        do {
            try await updateEmail(email: "example@example.com")
        } catch {
            print("Error updating email: \(error.localizedDescription)")
        }
    }
    
    func updateName(name: String) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        do {
            try await changeRequest?.commitChanges()
        } catch {
            throw error
        }
    }
    
    //    func updateViewProfile(displayName: String) {
    //        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    //        changeRequest?.displayName = displayName
    //        changeRequest?.commitChanges { error in
    //          // ...
    //        }
    //    }
    
    func signInListener(_ listener: @escaping (Auth, User?) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
        }
    }
    
    
    //    func saveFiresore(user: UserData) {
    //        if let uid = result?.user.uid {
    //        Firestore.firestore()
    //            .collection("Users")
    //            .document()
    //    }
    
    //    func registrationUser(user: UserData) {
    //        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
    //            guard error == nil else {
    //                print(error!.localizedDescription)
    //                return
    //            }
    //
    //            if let uid = result?.user.uid {
    //                Firestore.firestore()
    //                    .collection("Users")
    //                    .document(uid)
    //                    .setData(["email" : user.email,
    //                              "name" : user.name,
    //                              "login" : user.login,
    //                              "password" : user.password,
    //                              "dateRegistration" : Date(),
    //                             ], merge: true) { error in
    //                        print("User was be created - \(uid)")
    //                    }
    //            }
    // ...
    //        }
    //    }
    
}



