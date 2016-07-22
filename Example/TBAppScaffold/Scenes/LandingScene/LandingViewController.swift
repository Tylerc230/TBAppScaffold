//
//  LandingViewController.swift
//  ArchitectureTest
//
//  Created by Tyler Casselman on 5/19/16.
//  Copyright © 2016 13bit consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSugar

class LandingViewController: UIViewController {
    @IBOutlet var signInButton: UIButton! = nil
    @IBOutlet var registerButton: UIButton! = nil
    var viewModel: LandingViewModel? = nil
    var registerButtonTapped: Observable<Bool> {
        return registerButton.rx_tap.map { true}
    }
    
    var signInButtonTapped: Observable<Bool> {
        return signInButton.rx_tap.map { true }
    }
    
    let disposeBag = DisposeBag()
}
