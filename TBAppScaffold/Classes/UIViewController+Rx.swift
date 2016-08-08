//
//  UIViewController+Rx.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 5/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension UIViewController {
    var prepareForSegue: Observable<UIViewController> {
        let selector = #selector(UIViewController.prepareForSegue(_:sender:))
        return rx_sentMessage(selector).map { parameters  in
            let segue = parameters.first as! UIStoryboardSegue
            return segue.destinationViewController
        }
    }
    
    var viewLoaded: Observable<UIViewController> {
        let selector = #selector(UIViewController.viewDidLoad)
        return rx_sentMessage(selector).mapTo(self).take(1)
    }
    
    var viewWillAppear: Observable<Void> {
        let selector = #selector(UIViewController.viewWillAppear(_:))
        return rx_sentMessage(selector).mapTo(Void())
    }
}
