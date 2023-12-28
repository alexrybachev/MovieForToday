//
//  FirebaseManager.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/28/23.
//

import Foundation
import Firebase

class FirebaseManager {
    func registrationUser(user: UserData) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            print(result?.user.uid)
            
              // ...
        }
    }
}

struct UserData {
    let login: String
    let password: String
    let name: String
    let email: String
}


