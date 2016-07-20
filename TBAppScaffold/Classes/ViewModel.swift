//
//  ViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 7/5/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
protocol ViewModel {
    associatedtype Event
    var events: PublishSubject<Event> { get }
}
