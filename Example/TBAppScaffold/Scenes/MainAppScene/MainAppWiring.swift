//
//  MainAppWiring.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 7/1/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift

struct MainAppWiring: Wiring {
    let viewModel = MainAppViewModel()
    func wire(viewController: MainAppViewController) {
        
    }
}