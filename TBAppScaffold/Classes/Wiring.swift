//
//  Wiring.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift
protocol Wiring {
    associatedtype ViewController: UIViewController
    associatedtype Model: ViewModel
    func wire(viewController: ViewController)
    func eventStream() -> Observable<Model.Event>
    var viewModel: Model { get }
}

extension Wiring {
    func eventStream() -> Observable<Model.Event> {
        return viewModel.events
    }
}

