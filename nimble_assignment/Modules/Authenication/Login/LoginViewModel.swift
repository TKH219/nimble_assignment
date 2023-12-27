//
//  LoginViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import RxSwift
import Swinject

class LoginViewModel: BaseViewModel {
        
    public let emailInput = BehaviorSubject<String>(value: "")
    public let passwordInput = BehaviorSubject<String>(value: "")
    public let loginSuccess = BehaviorSubject<Bool>(value: false)
    
    public let signInActivityIndicatorAnimating = BehaviorSubject<Bool>(value: false)
    
    @objc
    public func signIn() {
        indicateSigningIn()
        let (email, password) = getEmailPassword()
        print(email)
        print(password)
        resolver.resolve(AuthenicationRepository.self)!.signIn(email: email, password: password).done { response in
            print(response)
            self.loginSuccess.onNext(true)
        }.catch {customError in
        
//                errorMessages
//              .asDriver(onErrorJustReturn: false)
//              .distinctUntilChanged()
//              .drive(onNext: { [weak self] isSuccess in
//                guard let strongSelf = self else {
//                  return
//                }
//              })
//              .disposed(by: DisposeBag())
        }
    }
    
    func indicateSigningIn() {
//        emailInputEnabled.onNext(false)
//        passwordInputEnabled.onNext(false)
//        signInButtonEnabled.onNext(false)
        signInActivityIndicatorAnimating.onNext(true)
    }
    
    func getEmailPassword() -> (String, String) {
        do {
            let email = try emailInput.value()
            let password = try passwordInput.value()
            return (email, password)
        } catch {
            fatalError("Error reading email and password from behavior subjects.")
        }
    }
}
