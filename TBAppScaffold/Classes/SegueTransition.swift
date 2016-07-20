//
//  SegueTransition.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
import UIKit

struct SegueTransition<W: Wiring>: Transition {
    typealias DestinationViewController = W.ViewController
    let sourceViewController: UIViewController
    let segueId: SegueId
    let wiring: W
    
    func performTransition() -> Observable<UIViewController> {
        var destination: UIViewController? = nil
        let disposable = sourceViewController.prepareForSegue.subscribeNext { (viewController) in
            destination = viewController
        }
        self.sourceViewController.performSegueWithIdentifier(self.segueId.rawValue, sender: self.sourceViewController)
        disposable.dispose()
        return Observable.just(destination!)
    }
}