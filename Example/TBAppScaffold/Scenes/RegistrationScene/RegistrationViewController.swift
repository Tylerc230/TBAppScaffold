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
        return nameTextField.rx.text.asObservable().ignoreNil()
    }
    
    var emailText: Observable<String> {
        return emailTextField.rx.text.asObservable().ignoreNil()
    }
    
    var passwordText: Observable<String> {
        return passwordTextField.rx.text.asObservable().ignoreNil()
    }
    
    var confPasswordText: Observable<String> {
        return confPasswordTextField.rx.text.asObservable().ignoreNil()
    }
    
    var signupButtonTapped: Observable<Bool> {
        return signUpButton.rx.tap.map { true }
    }
    
    @IBOutlet fileprivate var nameTextField: UITextField!
    @IBOutlet fileprivate var nameStateView: UIView!
    
    @IBOutlet fileprivate var emailTextField: UITextField!
    @IBOutlet fileprivate var emailStateView: UIView!
    
    @IBOutlet fileprivate var passwordTextField: UITextField!
    @IBOutlet fileprivate var passwordStateView: UIView!
    
    @IBOutlet fileprivate var confPasswordTextField: UITextField!
    @IBOutlet fileprivate var confPasswordStateView: UIView!
    
    @IBOutlet fileprivate var signUpButton: UIButton!
    var viewModel: RegistrationViewModel? = nil
    let disposeBag = DisposeBag()
    
    func setNameState(_ nameState: Observable<FieldState>, emailState: Observable<FieldState>, passwordState: Observable<FieldState>, confPasswordState: Observable<FieldState>, signUpButtonEnabledState: Observable<Bool>) {
        disposeBag
            ++ nameStateView.rx_backgroundColor <~ nameState.map(stateToColor)
            ++ emailStateView.rx_backgroundColor <~ emailState.map(stateToColor)
            ++ passwordStateView.rx_backgroundColor <~ passwordState.map(stateToColor)
            ++ confPasswordStateView.rx_backgroundColor <~ confPasswordState.map(stateToColor)
            ++ signUpButton.rx.isEnabled <~ signUpButtonEnabledState
    }
}

private func stateToColor(_ fieldState: FieldState) -> UIColor {
    switch fieldState {
    case .unset:
        return UIColor.clear
    case .invalid:
        return UIColor.red
    case .valid:
        return UIColor.green
    }
}

extension UIView {
    public var rx_backgroundColor: AnyObserver<UIColor> {
        return UIBindingObserver(UIElement: self) { (view, color) in
            view.backgroundColor = color
        }.asObserver()
    }
}
