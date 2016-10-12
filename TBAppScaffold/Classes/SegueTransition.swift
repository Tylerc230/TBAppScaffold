//
//  SegueTransition.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
import RxSugar

public protocol SegueIdType {
    var identifier: String { get }
}

public struct SegueTransition<W: Wiring, S: SegueIdType>: PresentTransition {
    let source: UIViewController
    public var destination: Observable<UIViewController> {
        return destinationSubject.asObservable()
    }
    private let destinationSubject = ReplaySubject<UIViewController>.create(bufferSize: 1)
    let segueId: S
    public let wiring: W
    public init(sourceViewController: UIViewController, segueId: S, wiring: W) {
        self.source = sourceViewController
        self.segueId = segueId
        self.wiring = wiring
        self.destinationSubject <~ sourceViewController.prepareForSegue
    }
    
    public func performTransition() {
        source.performSegueWithIdentifier(self.segueId.identifier, sender: self.source)
    }
}