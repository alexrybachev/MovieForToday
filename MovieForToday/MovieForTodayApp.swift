//
//  MovieForTodayApp.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import Networking

@main
struct MovieForTodayApp: App {
    @AppStorage("isOnboarding") var isOnboarding = false
    @Environment(\.scenePhase) var scenePhase
    let networking = NetworkManager(apiKey: "91FNPYK-28Z4N08-K3AEZFE-G1204N7")
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}
