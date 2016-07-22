//
//  RegistrationViewController.swift
//  TBAppScaffold
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSugar

class RegistrationViewController: UIViewController {
    var nameText: Observable<String> {
        return nameTextField.rx_text.asObservable()
    }
    
    var emailText: Observable<String> {
        return emailTextField.rx_text.asObservable()
    }
    
    var passwordText: Observable<String> {
        return passwordTextField.rx_text.asObservable()
    }
    
    var confPasswordText: Observable<String> {
        return confPasswordTextField.rx_text.asObservable()
    }
    
    var signupButtonTapped: Observable<Bool> {
        return signUpButton.rx_tap.map { true }
    }
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var nameStateView: UIView!
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var emailStateView: UIView!
    
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordStateView: UIView!
    
    @IBOutlet private var confPasswordTextField: UITextField!
    @IBOutlet private var confPasswordStateView: UIView!
    
    @IBOutlet private var signUpButton: UIButton!
    var viewModel: RegistrationViewModel? = nil
    let disposeBag = DisposeBag()
    
    func setNameState(nameState: Observable<FieldState>, emailState: Observable<FieldState>, passwordState: Observable<FieldState>, confPasswordState: Observable<FieldState>, signUpButtonEnabledState: Observable<Bool>) {
        disposeBag
            ++ nameStateView.rx_backgroundColor <~ nameState.map(stateToColor)
            ++ emailStateView.rx_backgroundColor <~ emailState.map(stateToColor)
            ++ passwordStateView.rx_backgroundColor <~ passwordState.map(stateToColor)
            ++ confPasswordStateView.rx_backgroundColor <~ confPasswordState.map(stateToColor)
            ++ signUpButton.rx_enabled <~ signUpButtonEnabledState
    }
}

private func stateToColor(fieldState: FieldState) -> UIColor {
    switch fieldState {
    case .unset:
        return UIColor.clearColor()
    case .invalid:
        return UIColor.redColor()
    case .valid:
        return UIColor.greenColor()
    }
}

extension UIView {
    public var rx_backgroundColor: AnyObserver<UIColor> {
        return UIBindingObserver(UIElement: self) { (view, color) in
            view.backgroundColor = color
        }.asObserver()
    }
}
