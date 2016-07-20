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

struct LandingViewModel: ViewModel {
    let events = PublishSubject<AppEvent>()
    let disposeBag = DisposeBag();
    func setRegistrationButtonTaps(registrationTaps: Observable<Bool>) {
        disposeBag
            ++ events <~ registrationTaps
                .map{ _ in AppEvent.registrationSelected}
    }
    
    func setSignInButtonTaps(signInTaps: Observable<Bool>) {
        disposeBag
            ++ events <~ signInTaps
                .map { _ in AppEvent.signInSelected}
    }
}
