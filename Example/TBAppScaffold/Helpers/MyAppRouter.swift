//
//  MyAppRouter.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/13/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import TBAppScaffold

enum SegueId: String, SegueIdType {
    case registrationSegue, signUpSegue, mainAppSegue
    var identifier: String {
        return self.rawValue
    }
}

enum AppEvent {
    case appLaunched, registrationSelected, signInSelected, registrationComplete, signInComplete
}

func transitionForEvent(source: UIViewController, event: AppEvent) -> AnyTransition<AppEvent> {
    let sourceViewController = source
    switch event {
    case .registrationComplete, .signInComplete:
        let wiring = MainAppWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: SegueId.mainAppSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .signInSelected:
        let wiring = SignInWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: SegueId.signUpSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .registrationSelected:
        let wiring = RegistrationWiring()
        let transition = SegueTransition(sourceViewController: sourceViewController, segueId: SegueId.registrationSegue, wiring: wiring)
        return AnyTransition(transition: transition)
    case .appLaunched:
        let wiring = LandingScreenWiring()
        let transition = ManualTransition(sourceViewController: sourceViewController, wiring: wiring) {
            guard let navController = sourceViewController as? UINavigationController else {
                fatalError()
            }
            return navController.topViewController as! LandingViewController
        }
        return AnyTransition(transition: transition)
    }
    
    
}