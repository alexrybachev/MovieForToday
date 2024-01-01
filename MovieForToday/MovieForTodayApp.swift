//
//  MovieForTodayApp.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import FirebaseCore


@main
struct MovieForTodayApp: App {
    private var testRegistration = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if testRegistration {
//                Registration(fullName: "", login: "", password: "", mail: "")
//                LogInView(login: "", password: "", mail: "")
                ProfileView(profileImage: "", name: "", mail: "")
            } else {
                ContentView()
            }
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
