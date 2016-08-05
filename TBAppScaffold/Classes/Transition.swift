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
    associatedtype W: Wiring
    var wiring: W { get }
    var destination: Observable<UIViewController> { get }
    func performTransition()
    func eventStream() -> Observable<W.Model.Event>
}

extension Transition {
    public func eventStream() -> Observable<W.Model.Event> {
        return wiring.eventStream()
    }
    
    func wireViewModel(to destination: W.ViewController) {
        self.wiring.wire(destination)
    }
}

public struct AnyTransition<Event> {
    let destination: Observable<UIViewController>
    private let performTransitionClosure: () -> ()
    private let eventStreamClosure: () -> Observable<Event>
    private let wireViewModelClosure: (viewController: UIViewController) -> ()
    public init<T: Transition where T.W.Model.Event == Event>(transition: T) {
        performTransitionClosure = transition.performTransition
        eventStreamClosure = transition.eventStream
        wireViewModelClosure = { viewController in
            transition.wireViewModel(to: viewController as! T.W.ViewController)
        }
        destination = transition.destination
    }
    
    func performTransition() {
        return performTransitionClosure()
    }
    
    func wireViewModel(to viewController: UIViewController) {
        return wireViewModelClosure(viewController: viewController)
    }
    
    func eventStream() -> Observable<Event> {
        return eventStreamClosure()
    }
}
