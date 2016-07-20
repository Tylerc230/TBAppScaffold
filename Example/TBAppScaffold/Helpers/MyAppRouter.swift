//
//  MyAppRouter.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/13/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit

enum SegueId:  String {
    case registrationSegue, signUpSegue, mainAppSegue
}

enum AppEvent {
    case appLaunched, registrationSelected, signInSelected, registrationComplete, signInComplete
}

func transitionForEvent(source: UIViewController, event: AppEvent) -> AnyTransition<AppEvent> {
    let sourceViewController = source
    switch event {
    case .registrationComplete, .signInComplete:
        let wiring = MainAppWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: .mainAppSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .signInSelected:
        let wiring = SignInWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: .signUpSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .registrationSelected:
        let wiring = RegistrationWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: .registrationSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .appLaunched:
        let transition = ManualTransition(sourceViewController: sourceViewController, wiring: LandingScreenWiring()) {
            guard let navController = sourceViewController as? UINavigationController else {
                fatalError()
            }
            return navController.topViewController as! LandingViewController
        }
        return AnyTransition(transition: transition)
    }
    
}