//
//  RegistrationWiring.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 7/1/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//
import RxSwift

struct RegistrationWiring: Wiring {
    let viewModel = RegistrationViewModel()
    func wire(registrationView: RegistrationViewController) {
        registrationView.viewModel = viewModel
        viewModel
            .setNameText(registrationView.nameText,
                         emailText: registrationView.emailText,
                         passwordText: registrationView.passwordText,
                         confPasswordText: registrationView.confPasswordText,
                         signupTapped: registrationView.signupButtonTapped)
        registrationView
            .setNameState(viewModel.nameStateStream,
                          emailState: viewModel.emailStateStream,
                          passwordState: viewModel.passwordStateStream,
                          confPasswordState: viewModel.confPasswordStateStream,
                          signUpButtonEnabledState: viewModel.signUpButtonEnabledStream)
    }
    
}