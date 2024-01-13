//
//  MovieForTodayApp.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import Networking
import FirebaseCore

@main
struct MovieForTodayApp: App {
    private var testRegistration = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isOnboarding = false
    @Environment(\.scenePhase) var scenePhase
    let networking = NetworkManager(apiKey: "NHF9KRY-Y43MNST-K5GMVR9-40FZPJS") // "91FNPYK-28Z4N08-K3AEZFE-G1204N7"
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ContentView(homeViewModel: homeViewModel)
                    .onAppear {
//                        homeViewModel.fetchMovieCollection()
                        homeViewModel.fetchCategories()
                    }
            } else {
                OnboardingView()
//                    .onAppear {
//                        homeViewModel.fetchMovieCollection()
//                        homeViewModel.fetchCategories()
//                    }
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
