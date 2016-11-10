//
//  Transition.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift

public protocol Transition {
    var destination: Observable<UIViewController> { get }
    func performTransition()
}

public protocol PresentTransition: Transition {
    associatedtype W: Wiring
    var wiring: W { get }
    func eventStream() -> Observable<W.Model.Event>
}

public protocol DismissTransition: Transition {
    
}

extension PresentTransition {
    public func eventStream() -> Observable<W.Model.Event> {
        return wiring.eventStream()
    }
    
    func wireViewModel(to destination: W.ViewController) {
        self.wiring.wire(destination)
    }
}

public struct AnyTransition<Event> {
    let destination: Observable<UIViewController>
    fileprivate let performTransitionClosure: () -> ()
    fileprivate let eventStreamClosure: () -> Observable<Event>
    fileprivate let wireViewModelClosure: (_ viewController: UIViewController) -> ()
    public init<T: PresentTransition>(transition: T) where T.W.Model.Event == Event {
        performTransitionClosure = transition.performTransition
        eventStreamClosure = transition.eventStream
        wireViewModelClosure = { viewController in
            transition.wireViewModel(to: viewController as! T.W.ViewController)
        }
        destination = transition.destination
    }

    public init<T: DismissTransition>(transition: T) {
        performTransitionClosure = transition.performTransition
        destination = transition.destination
        wireViewModelClosure = {_ in }
        eventStreamClosure = {Observable<Event>.never()}
    }
    
    func performTransition() {
        performTransitionClosure()
    }
    
    func wireViewModel(to viewController: UIViewController) {
        wireViewModelClosure(viewController)
    }
    
    func eventStream() -> Observable<Event> {
        return eventStreamClosure()
    }
}
