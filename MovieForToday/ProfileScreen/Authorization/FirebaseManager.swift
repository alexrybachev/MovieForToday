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
    let email: String?
    let photoUrl: String?
    //    let date: Date
    
    init(user: User) {
        self.uid = user.uid
        self.login = user.uid
        self.name = user.displayName
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        //        self.date = Date()
    }
}

final class FirebaseManager {
    static let shared = FirebaseManager()
    var isUserAuthenticated = false
    private init() {}
    
    func getAuthenticatedUser() throws -> UserData  {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return UserData.init(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> UserData {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserData(user: authData.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> UserData {
        let authDataResults = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserData(user: authDataResults.user)
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
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



