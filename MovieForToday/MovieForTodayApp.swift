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
    @Environment(\.scenePhase) var scenePhase
    let networking = NetworkManager(apiKey: "91FNPYK-28Z4N08-K3AEZFE-G1204N7")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    do {
                        let result = try await networking.getTop10Movies()
                        print(result.docs.count)
                    } catch {
                        print(error)
                    }
                }
        }
    }
}
