//
//  Router.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa
import RxSugar

public class Router<Event> {
    public typealias SourcedEvent = (source: UIViewController, event: Event)
    public typealias EventTransitionMap = SourcedEvent -> AnyTransition<Event>
    let disposeBag = DisposeBag()
    let currentEventStream = PublishSubject<SourcedEvent>()
    public init(eventTransitionMap: EventTransitionMap) {
        setupRx(eventTransitionMap)
    }
    
    public func sendEvent(event: Event, withSource source: UIViewController) {
        currentEventStream.onNext((source, event))
    }
    
    private func setupRx(eventTransitionMap: EventTransitionMap) {
        currentEventStream
            .asObservable()
            .map (eventTransitionMap)//Map an event to a transition object
            .flatMap{ (transition)  in
                return transition.performTransition().map {destination in (transition, destination) }
            }
            .doOnNext { (transition, destination) in
                transition.wireViewModel(to: destination)
            }
            .subscribeNext{ (transition, destination) in
                self.addNewEventStream(transition, destination: destination)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func addNewEventStream(transition: AnyTransition<Event>, destination: UIViewController) {
        disposeBag
            ++ currentEventStream <~ Observable.combineLatest(Observable.just(destination), transition.eventStream()) {
                return ($0, $1)
        }
        
    }
}

