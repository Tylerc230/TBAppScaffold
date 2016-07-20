//
//  RegistrationViewController.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSugar

class RegistrationViewController: UIViewController {
    let nameText = BehaviorSubject<String>(value: "")
    private let nameFieldState = BehaviorSubject<FieldState>(value: .unset)
    
    let emailText = BehaviorSubject<String>(value: "")
    private let emailFieldState = BehaviorSubject<FieldState>(value: .unset)
    
    let passwordText = BehaviorSubject<String>(value: "")
    private let passwordFieldState = BehaviorSubject<FieldState>(value: .unset)
    
    let confPasswordText = BehaviorSubject<String>(value: "")
    private let confPasswordFieldState = BehaviorSubject<FieldState>(value: .unset)
    
    let signupButtonTapped = PublishSubject<Bool>()
    
    private let signUpButtonEnabled = BehaviorSubject<Bool>(value: false)
    
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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setNameState(nameState: Observable<FieldState>, emailState: Observable<FieldState>, passwordState: Observable<FieldState>, confPasswordState: Observable<FieldState>, signUpButtonEnabledState: Observable<Bool>) {
        disposeBag
            ++ nameFieldState <~ nameState
            ++ emailFieldState <~ emailState
            ++ passwordFieldState <~ passwordState
            ++ confPasswordFieldState <~ confPasswordState
            ++ signUpButtonEnabled <~ signUpButtonEnabledState
    }
    
    private func setupRx() {
        bindTextFields()
        bindFieldStateViews()
        bindSignUpButton()
    }
    
    private func bindTextFields() {
        disposeBag
            ++ nameText <~ nameTextField.rx_text
            ++ emailText <~ emailTextField.rx_text
            ++ passwordText <~ passwordTextField.rx_text
            ++ confPasswordText <~ confPasswordTextField.rx_text
    }
    
    private func bindFieldStateViews() {
        disposeBag
            ++ nameStateView.rx_backgroundColor <~ nameFieldState.map(stateToColor)
            ++ emailStateView.rx_backgroundColor <~ emailFieldState.map(stateToColor)
            ++ passwordStateView.rx_backgroundColor <~ passwordFieldState.map(stateToColor)
            ++ confPasswordStateView.rx_backgroundColor <~ confPasswordFieldState.map(stateToColor)
    }
    
    private func bindSignUpButton() {
        disposeBag
            ++ signUpButton.rx_enabled <~ signUpButtonEnabled
            ++ signupButtonTapped <~ signUpButton.rx_tap.map{true}
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
