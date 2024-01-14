//
//  MovieForTodayApp.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import Networking
import FirebaseCore
import FirebaseFirestore

@main
struct MovieForTodayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isOnboarding = false
    @Environment(\.scenePhase) var scenePhase
    let networking = NetworkManager(apiKey: "91FNPYK-28Z4N08-K3AEZFE-G1204N7")
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ContentView()
                    .preferredColorScheme(.dark)
            } else {
                OnboardingView()
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
