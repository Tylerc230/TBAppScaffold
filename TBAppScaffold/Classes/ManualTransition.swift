//
//  ManualTransition.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift

public struct ManualTransition<W: Wiring>: Transition {
    typealias DestinationViewController = W.ViewController
    public typealias TransitionOperation = () -> DestinationViewController
    let sourceViewController: UIViewController
    public let wiring: W
    let transitionOperation: TransitionOperation
    
    public init(sourceViewController: UIViewController, wiring: W, transitionOperation: TransitionOperation) {
        self.sourceViewController = sourceViewController
        self.wiring = wiring
        self.transitionOperation = transitionOperation
    }
    
    public func performTransition() -> Observable<UIViewController> {
        let destinationViewController = transitionOperation()
        return Observable.just(destinationViewController)
    }
}