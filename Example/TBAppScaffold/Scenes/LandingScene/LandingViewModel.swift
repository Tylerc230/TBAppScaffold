//
//  LandingViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/28/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxSugar
import TBAppScaffold

struct LandingViewModel: ViewModel {
    var events: Observable<AppEvent> {
        return [
            registrationTaps.map { _ in AppEvent.registrationSelected },
            signInTaps.map { _ in AppEvent.signInSelected }
        ]
            .toObservable()
            .merge()
    }
    let registrationTaps = PublishSubject<Bool>()
    let signInTaps = PublishSubject<Bool>()
}
