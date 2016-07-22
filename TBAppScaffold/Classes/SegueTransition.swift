//
//  SegueTransition.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift

public protocol SegueIdType {
    var identifier: String { get }
}

public struct SegueTransition<W: Wiring, S: SegueIdType>: Transition {
    typealias DestinationViewController = W.ViewController
    let sourceViewController: UIViewController
    let segueId: S
    public let wiring: W
    public init(sourceViewController: UIViewController, segueId: S, wiring: W) {
        self.sourceViewController = sourceViewController
        self.segueId = segueId
        self.wiring = wiring
    }
    
    public func performTransition() -> Observable<UIViewController> {
        var destination: UIViewController? = nil
        let disposable = sourceViewController.prepareForSegue.subscribeNext { (viewController) in
            destination = viewController
        }
        self.sourceViewController.performSegueWithIdentifier(self.segueId.identifier, sender: self.sourceViewController)
        disposable.dispose()
        return Observable.just(destination!)
    }
}