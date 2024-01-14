//
//  OnboardingView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        ZStack {
            VStack {
                OnboardingScreenView()
            }
        }
        .background(Color.customMain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    OnboardingView()
}
