//
//  MainAppWiring.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 7/1/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift
import TBAppScaffold

struct MainAppWiring: Wiring {
    let viewModel = MainAppViewModel()
    func wire(_ viewController: MainAppViewController) {
        
    }
}
