//
//  OnboardingStepModel.swift
//  MovieForToday
//
//  Created by Мирсаит Сабирзянов on 03.01.2024.
//

import Foundation

struct OnboardingStep {
    let image: String
    let title: String
    let description: String
    let buttonImage: String

}

extension OnboardingStep {
    static func createSteps() -> [OnboardingStep] {
        [
            OnboardingStep(
                image: "screen1",
                title: "Genre diversity",
                description: "Explore the richness of cinema by genre. From drama and comedy to fiction and thriller, we have films for all tastes. Find your favorite genre or discover something new",
                buttonImage: "one_third_btn"
            ),
            OnboardingStep(
                image: "screen2",
                title: "Find moview",
                description: "Watch and find movies that bring your mood back",
                buttonImage: "two_third_btn"
            ),
            OnboardingStep(
                image: "screen3",
                title: "Popular now",
                description: "Take a look into the world of the hottest movies and TV series that are being discussed all over the world. Discover the latest hits and novelties right now",
                buttonImage: "three_third_btn"

            )
        ]
    }
}
