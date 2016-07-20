//
//  UIViewController+Rx.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/30/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    var prepareForSegue: Observable<UIViewController> {
        let selector = #selector(UIViewController.prepareForSegue(_:sender:))
        return rx_sentMessage(selector).map { parameters  in
            let segue = parameters.first as! UIStoryboardSegue
            return segue.destinationViewController
        }
    }
    
    var viewLoaded: Observable<UIViewController> {
        let selector = #selector(UIViewController.viewDidLoad)
        return rx_sentMessage(selector).map {_ in self}.take(1)
    }
}
