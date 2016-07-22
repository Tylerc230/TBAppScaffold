//
//  LandingScreenWiring.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
import RxSugar
import TBAppScaffold

struct LandingScreenWiring: Wiring {
    let viewModel = LandingViewModel()
    func wire(landingView: LandingViewController) {
        landingView.disposeBag
            ++ viewModel.signInTaps <~ landingView.signInButtonTapped
            ++ viewModel.registrationTaps <~ landingView.registerButtonTapped
        landingView.viewModel = viewModel
    }
}