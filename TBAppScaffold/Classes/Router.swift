//
//  Router.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa
import RxSugar

open class Router<Event> {
    public typealias SourcedEvent = (source: UIViewController, event: Event)
    public typealias EventTransitionMap = (SourcedEvent) -> AnyTransition<Event>
    let disposeBag = DisposeBag()
    let currentEventStream = PublishSubject<SourcedEvent>()
    public init(eventTransitionMap: @escaping EventTransitionMap) {
        setupRx(eventTransitionMap)
    }
    
    open func sendEvent(_ event: Event, withSource source: UIViewController) {
        currentEventStream.onNext((source, event))
    }
    
    fileprivate func setupRx(_ eventTransitionMap: @escaping EventTransitionMap) {
        let transitions = currentEventStream
            .asObservable()
            .map (eventTransitionMap)//Map an event to a transition object
            .shareReplay(1)
        
        transitions
            .flatMap { transition in
                return transition.destination.map { (transition, $0) }
            }
            .flatMap { (transition, destination) in
                return destination.viewLoaded.map { _ in (transition, destination) }
            }
            .subscribe(onNext: { (transition, destination) in
                transition.wireViewModel(to: destination)
            })
            .addDisposableTo(disposeBag)
        
        transitions
            .subscribe(onNext: { (transition) in
                transition.performTransition()
                self.addNewEventStream(transition.eventStream(), destination: transition.destination)
            })
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func addNewEventStream(_ eventStream: Observable<Event>, destination: Observable<UIViewController>) {
        disposeBag
            ++ currentEventStream <~ Observable<SourcedEvent>.combineLatest(destination, eventStream) {
                return ($0, $1)
        }
        
    }
}

