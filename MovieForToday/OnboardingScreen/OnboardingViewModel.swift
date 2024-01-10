//
//  OnboardingViewModel.swift
//  MovieForToday
//
//  Created by Мирсаит Сабирзянов on 03.01.2024.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var source = OnboardingStep.createSteps()
    @Published var currentStep: Int = 0
            
    func stepHandler() -> Bool {
        if currentStep < source.count - 1 {
            self.currentStep += 1
            return false
        } else {
            return true
        }
    }
}
