//
//  RegistrationWiring.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 7/1/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift
import RxSugar
import TBAppScaffold

struct RegistrationWiring: Wiring {
    let viewModel = RegistrationViewModel()
    func wire(registrationView: RegistrationViewController) {
        registrationView.viewModel = viewModel
        registrationView.disposeBag
            ++ viewModel.nameTextStream <~ registrationView.nameText
            ++ viewModel.emailTextStream <~ registrationView.emailText
            ++ viewModel.passwordTextStream <~ registrationView.passwordText
            ++ viewModel.confPasswordTextStream <~ registrationView.confPasswordText
            ++ viewModel.signupTappedStream <~ registrationView.signupButtonTapped
        
        registrationView
            .setNameState(viewModel.nameStateStream,
                          emailState: viewModel.emailStateStream,
                          passwordState: viewModel.passwordStateStream,
                          confPasswordState: viewModel.confPasswordStateStream,
                          signUpButtonEnabledState: viewModel.signUpButtonEnabledStream)
    }
    
}