//
//  RegistrationViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/7/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//


import RxSwift
import RxSugar
import TBAppScaffold

enum FieldState {
    case unset, invalid, valid
}

struct RegistrationViewModel: ViewModel {
    //Outgoing streams
    var nameStateStream: Observable<FieldState> {
        return nameTextStream.map(validName).startWith(.unset)
    }
    
    var emailStateStream: Observable<FieldState> {
        return emailTextStream.map (validEmail).startWith(.unset)
    }
    
    var passwordStateStream: Observable<FieldState> {
        return passwordTextStream.map (validPassword).startWith(.unset)
    }
    
    var confPasswordStateStream: Observable<FieldState> {
        return Observable.combineLatest(passwordTextStream, confPasswordTextStream) {
            return ($0, $1)
            }
            .map (validConfPassword).startWith(.unset)
    }
    
    var signUpButtonEnabledStream: Observable<Bool> {
        return [nameStateStream, emailStateStream, passwordStateStream, confPasswordStateStream].combineLatest { states in
            return states.reduce(true, combine: allValid)
        }
    }
    
    var events: Observable<AppEvent> {
        return signupTappedStream
            .map { _ in return AppEvent.registrationComplete }
    }
    
    //incoming streams
    let nameTextStream = PublishSubject<String>()
    let emailTextStream = PublishSubject<String>()
    let passwordTextStream = PublishSubject<String>()
    let confPasswordTextStream = PublishSubject<String>()
    let signupTappedStream = PublishSubject<Bool>()
}

private func validName(name: String) -> FieldState {
    switch name {
    case "":
        return .unset
    case _ where name.characters.count < 6:
        return .invalid
    default:
        return .valid
    }
}

private func validEmail(email: String) -> FieldState {
    switch email {
    case "":
        return .unset
    case _ where email.rangeOfString(".+@.+\\..+", options: .RegularExpressionSearch) == nil:
        return .invalid
    default:
        return .valid
    }
}

private func validPassword(password: String) -> FieldState {
    switch password {
    case "":
        return .unset
    case _ where password.characters.count < 6:
        return .invalid
    default:
        return .valid
    }
}

private func validConfPassword(password: String, confPassword: String) -> FieldState {
    switch confPassword {
    case "":
        return .unset
    case _ where confPassword != password:
        return .invalid
    default:
        return .valid
    }
}

private func allValid(valid: Bool, state: FieldState) -> Bool {
    if state == .valid {
        return valid
    } else {
        return false
    }
}