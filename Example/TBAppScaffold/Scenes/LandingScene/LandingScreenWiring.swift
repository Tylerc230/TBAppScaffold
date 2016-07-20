//
//  LandingScreenWiring.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
struct LandingScreenWiring: Wiring {
    let viewModel = LandingViewModel()
    func wire(landingView: LandingViewController) {
        viewModel.setSignInButtonTaps(landingView.signInButtonTapped)
        viewModel.setRegistrationButtonTaps(landingView.registerButtonTapped)
        landingView.viewModel = viewModel
    }
}