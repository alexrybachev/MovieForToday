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

let globalKey = "JSRX406-H8HMG9X-N16CB79-WGWC9Y7"


// "91FNPYK-28Z4N08-K3AEZFE-G1204N7" - Илья
// "NHF9KRY-Y43MNST-K5GMVR9-40FZPJS" - Alex
// "BR9GX9R-2TD4AQX-H67HE11-CSGFVP4" - Unknowed

// VLAD KEYS
// CA0Y6V3-4JPMCKW-PTSQ135-YPKXT4X - не работает
// 1TMH0NP-45VMCVB-J4Y4RF6-TZQ7ZW7 - не работает
// YGNWPD2-KY7MSX4-KTC4RS6-H8W2C2M - не работает
// RH9700B-VAJ47JC-P92YAMQ-5WRVNRQ
// BR9GX9R-2TD4AQX-H67HE11-CSGFVP4
// 4M3ZC0R-XYV44S1-QE7HWZA-ASPTETW
// MEY4BQK-S3G4X7A-QWH2AEP-MKCHDYX - скорее всего сдох

// JSRX406-H8HMG9X-N16CB79-WGWC9Y7 - не работает

@main
struct MovieForTodayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isOnboarding = false
    @StateObject private var signInViewModel = SignInViewModel()
    let networking = NetworkManager(apiKey: globalKey)
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ContentView(homeViewModel: homeViewModel)
                    .preferredColorScheme(.dark)
                    .onAppear {
                        homeViewModel.fetchMovieCollection()
                        homeViewModel.fetchCategories()
                        homeViewModel.fetchContent()
                    }
                    .environmentObject(signInViewModel)
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
