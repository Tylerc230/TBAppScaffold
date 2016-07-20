//
//  RegistrationViewModel.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 6/7/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//


import RxSwift
import RxSugar
enum FieldState {
    case unset, invalid, valid
}

struct RegistrationViewModel: ViewModel {
    //Outgoing streams
    let nameStateStream: Observable<FieldState>
    let emailStateStream: Observable<FieldState>
    let passwordStateStream: Observable<FieldState>
    let confPasswordStateStream: Observable<FieldState>
    let signUpButtonEnabledStream: Observable<Bool>
    let events = PublishSubject<AppEvent>()
    //incoming streams
    private let nameTextStream = PublishSubject<String>()
    private let emailTextStream = PublishSubject<String>()
    private let passwordTextStream = PublishSubject<String>()
    private let confPasswordTextStream = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    init() {
        nameStateStream = nameTextStream.map(validName)
        emailStateStream = emailTextStream.map (validEmail)
        passwordStateStream = passwordTextStream.map (validPassword)
        confPasswordStateStream = Observable.combineLatest(passwordTextStream, confPasswordTextStream) {
            return ($0, $1)
            }
            .map (validConfPassword)
        
        signUpButtonEnabledStream = [nameStateStream, emailStateStream, passwordStateStream, confPasswordStateStream].combineLatest { states in
            return states.reduce(true, combine: allValid)
        }
    }
    
    func setNameText(nameText: Observable<String>, emailText: Observable<String>, passwordText: Observable<String>, confPasswordText: Observable<String>, signupTapped: Observable<Bool>) {
        disposeBag
            ++ nameTextStream <~ nameText
            ++ emailTextStream <~ emailText
            ++ passwordTextStream <~ passwordText
            ++ confPasswordTextStream <~ confPasswordText
            ++ events <~ signupTapped
                .map { _ in return AppEvent.registrationComplete }
        
    }
    
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