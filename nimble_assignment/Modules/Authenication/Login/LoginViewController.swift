//
//  LoginViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: BaseViewController<LoginViewModel>, UITextFieldDelegate {
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"login_background")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"nimble_logo_white")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(padding: UIEdgeInsets.init(top: 19, left: 12, bottom: 15, right:12))
        textField.setPlaceHolder("Email")
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(padding: UIEdgeInsets.init(top: 19, left: 12, bottom: 15, right: 12))
        textField.setPlaceHolder("Password")
        textField.delegate = self
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: CustomButton = {
        let button = CustomButton(frame: .zero)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .equalCentering
        return stack
    }()
    
    override func setupView() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(stackView)
        self.view.addSubview(logoImage)
        
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.height.equalTo(frameScreen.height)
            make.width.equalTo(frameScreen.width)
        }
        
        self.emailTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        self.passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.centerY.centerX.equalToSuperview()
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.width.left.right.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.stackView.snp.top).offset(-109)
            make.height.equalTo(40)
            make.width.equalTo(168)
        }
    }
    
    override func bindViewToViewModel() {
        super.bindViewToViewModel()
        bindEmailField()
        bindPasswordField()
        loginButton.addTarget(viewModel,
                              action: #selector(viewModel.signIn),
                              for: .touchUpInside)
    }
    
    override func bindViewModelToView() {
        viewModel
            .loginSuccess
          .asDriver(onErrorJustReturn: false)
          .distinctUntilChanged()
          .drive(onNext: { [weak self] isSuccess in
            guard let strongSelf = self else {
              return
            }
              
              if (isSuccess) {
                  strongSelf.navigationController?.setViewControllers(
                      [strongSelf.resolver.resolve(SplashViewController.self)!],
                      animated: false
                  )
              }
          })
          .disposed(by: disposeBag)
    }
    
    func bindEmailField() {
        emailTextField.rx.text
            .asDriver()
            .map { $0 ?? "" }
            .drive(viewModel.emailInput)
            .disposed(by: disposeBag)
    }
    
    func bindPasswordField() {
        passwordTextField.rx.text
            .asDriver()
            .map { $0 ?? "" }
            .drive(viewModel.passwordInput)
            .disposed(by: disposeBag)
    }
}
