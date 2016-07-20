//
//  SignInViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/6/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import RxSwift
import TBAppScaffold

struct SignInViewModel: ViewModel {
    var events = PublishSubject<AppEvent>()
}
