//
//  AppDelegate.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import TBAppScaffold

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = Router(eventTransitionMap: transitionForEvent)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        guard let nav = window?.rootViewController as? UINavigationController else {
            fatalError()
        }
        router.sendEvent(.appLaunched, withSource: nav)
        return true
    }
    
}

