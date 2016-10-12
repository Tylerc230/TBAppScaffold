//
//  ManualTransition.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift

public struct ManualTransition<W: Wiring>: PresentTransition {
    typealias DestinationViewController = W.ViewController
    public typealias TransitionOperation = () -> DestinationViewController
    let source: UIViewController
    private let destinationSubject = BehaviorSubject<UIViewController?>(value: nil)
    public var destination: Observable<UIViewController> {
        return destinationSubject.unwrap()
    }
    public let wiring: W
    let transitionOperation: TransitionOperation
    
    public init(sourceViewController: UIViewController, wiring: W, transitionOperation: TransitionOperation) {
        self.source = sourceViewController
        self.wiring = wiring
        self.transitionOperation = transitionOperation
    }
    
    public func performTransition()  {
        let destinationViewController = transitionOperation()
        destinationSubject.onNext(destinationViewController)
    }
}