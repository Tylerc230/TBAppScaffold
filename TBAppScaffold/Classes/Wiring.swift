//
//  Wiring.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift
public protocol Wiring {
    associatedtype ViewController: UIViewController
    associatedtype Model: ViewModel
    func wire(_ viewController: ViewController)
    func eventStream() -> Observable<Model.Event>
    var viewModel: Model { get }
}

public extension Wiring {
    func eventStream() -> Observable<Model.Event> {
        return viewModel.events
    }
}

