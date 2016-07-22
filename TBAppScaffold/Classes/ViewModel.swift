//
//  ViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 7/5/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
public protocol ViewModel {
    associatedtype Event
    var events: Observable<Event> { get }
}
