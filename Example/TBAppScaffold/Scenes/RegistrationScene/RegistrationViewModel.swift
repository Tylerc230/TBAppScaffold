//
//  RegistrationViewModel.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 6/7/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//


import RxSwift
import RxSugar
import TBAppScaffold
import RxSwiftExt

enum FieldState {
    case unset, invalid, valid
}

struct RegistrationViewModel: ViewModel {
    //Outgoing streams
    var nameStateStream: Observable<FieldState> {
        return nameTextStream.map(validName)
    }
    
    var emailStateStream: Observable<FieldState> {
        return emailTextStream.map (validEmail)
    }
    
    var passwordStateStream: Observable<FieldState> {
        return passwordTextStream.map (validPassword)
    }
    
    var confPasswordStateStream: Observable<FieldState> {
        return Observable.combineLatest(passwordTextStream, confPasswordTextStream) {
            return ($0, $1)
            }
            .map (validConfPassword)
    }
    
    var signUpButtonEnabledStream: Observable<Bool> {
        return [nameStateStream, emailStateStream, passwordStateStream, confPasswordStateStream].combineLatest { states in
            return states.reduce(true, combine: allValid)
        }
    }
    
    var events: Observable<AppEvent> {
        return signupTappedStream
            .filter { $0 }
            .map { _ in return AppEvent.registrationComplete }
    }
    
    //incoming streams
    let nameTextStream = BehaviorSubject<String>(value: "")
    let emailTextStream = BehaviorSubject<String>(value: "")
    let passwordTextStream = BehaviorSubject<String>(value: "")
    let confPasswordTextStream = BehaviorSubject<String>(value: "")
    let signupTappedStream = BehaviorSubject<Bool>(value: false)
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