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
    let registerButtonTapped = PublishSubject<Bool>()
    let signInButtonTapped = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        disposeBag
            ++ signInButtonTapped <~ signInButton.rx_tap.map{ true }
            ++ registerButtonTapped <~ registerButton.rx_tap.map {true}
    }
}
