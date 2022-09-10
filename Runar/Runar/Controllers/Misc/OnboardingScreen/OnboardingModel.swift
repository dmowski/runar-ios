//
//  OnboardingModel.swift
//  Runar
//
//  Created by Виталий Татун on 27.07.22.
//

import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}

extension OnboardingSlide {

    public static func slides() -> [OnboardingSlide] {
        let onboardingSlides: [OnboardingSlide] = [
            OnboardingSlide(title: L10n.Onboarding.aboutTitle, description: L10n.Onboarding.aboutDescription, image: Assets.about.image),
            OnboardingSlide(title: L10n.Onboarding.howToTitle, description: L10n.Onboarding.howToDescription, image: Assets.howTo.image),
            OnboardingSlide(title: L10n.Onboarding.explanationTitle, description: L10n.Onboarding.explanationDescription, image: Assets.explanation.image),
            OnboardingSlide(title: L10n.Onboarding.favoritesTitle, description: L10n.Onboarding.favoritesDescription, image: Assets.favorites.image),
            OnboardingSlide(title: L10n.Onboarding.generatorTitle, description: L10n.Onboarding.generatorDescription, image: Assets.generator.image),
            OnboardingSlide(title: L10n.Onboarding.libraryTitle, description: L10n.Onboarding.libraryDescription, image: Assets.library.image)
        ]
        return onboardingSlides
    }
}

