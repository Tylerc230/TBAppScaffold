//
//  ManualDismissTransition.swift
//  Pods
//
//  Created by Tyler Casselman on 9/14/16.
//
//
import RxSwift

public struct ManualDismissTransition: DismissTransition {
    public let destination = Observable<UIViewController>.never()
    public let sourceViewController: UIViewController
    public init(source: UIViewController) {
        sourceViewController = source
    }
    public func performTransition() {
        sourceViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
