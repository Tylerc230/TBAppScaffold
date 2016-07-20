//
//  ManualTransition.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift

struct ManualTransition<W: Wiring>: Transition {
    typealias Event = W.Model.Event
    typealias DestinationViewController = W.ViewController
    let sourceViewController: UIViewController
    let wiring: W
    let transitionOperation: () -> DestinationViewController
    
    func performTransition() -> Observable<UIViewController> {
        let destinationViewController = transitionOperation()
        return Observable.just(destinationViewController)
    }
}