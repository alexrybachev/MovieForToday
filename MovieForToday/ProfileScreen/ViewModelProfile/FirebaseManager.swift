//
//  FirebaseManager.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

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

struct SaveUser {
    let userId: String
    let userName: String?
    let userPhoto: URL
    let userMail: String
}

final class FirebaseManager {
    static let shared = FirebaseManager()
    var error: ErrorMessage?
    private init() {}
    
    func getAuthenticatedUser() throws -> UserData  {
        guard let user = Auth.auth().currentUser else {
            self.error?.error = String(URLError(.badServerResponse).localizedDescription)
            throw URLError(.badServerResponse)
        }
        return UserData.init(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> UserData {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        try await saveUser(user: authData.user)
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
            self.error?.error = String(error.localizedDescription)
        }
    }
    
    //MARK: Update user name
    func updateName(name: String) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        do {
            try await changeRequest?.commitChanges()
        } catch {
            self.error?.error = error.localizedDescription
            throw error
        }
    }
    
    func signInListener(_ listener: @escaping (Auth, User?) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
        }
    }
    
    //MARK: - Save user in firestore
    func saveUser(user: User) async throws  {
        var userData: [String: Any] = [
            "user_id" : user.uid,
            "date_created" : Timestamp()
        ]
        
        if let name = user.displayName {
            userData["user_name"] = name
        }
        
        if let userPhoto = user.photoURL {
            userData["user_photo"] = userPhoto
        }
        
        if let userMail = user.email {
            userData["user_mail"] = userMail
        }
        
        try await Firestore.firestore()
            .collection("Users")
            .document(user.uid)
            .setData(userData, merge: true)
    }
    
    //MARK: - Get user data from Firebase
    func getUserData(userId: String) async throws -> SaveUser {
       let saveData = try await Firestore.firestore()
            .collection("Users")
            .document(userId)
            .getDocument()
        
        guard let data = saveData.data(), let userId = data["user_id"] as? String, let userPhoto = data["user_photo"] as! URL? else {
            throw URLError(.badServerResponse)
        }
        
        let userName = data["user_name"] as! String?
        let userMail = data["user_mail"] as! String
        return SaveUser(userId: userId, userName: userName, userPhoto: userPhoto, userMail: userMail)
    }
}



