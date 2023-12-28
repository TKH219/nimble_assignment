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
        
    func getEmailPassword() -> (String, String) {
        do {
            let email = try emailInput.value()
            let password = try passwordInput.value()
            return (email, password)
        } catch {
            fatalError("Error reading email and password from behavior subjects.")
        }
    }
    
    @objc
    public func signIn() {
        let (email, password) = getEmailPassword()
        resolver.resolve(AuthenicationRepository.self)!
            .signIn(email: email, password: password)
            .trackActivity(activityIndicator)
            .subscribe(
                onNext: {(response) in
                    self.loginSuccess.onNext(true)
                },
                onError: { (error) in
                    self.errorHandler(error)
                })
            .disposed(by: rx.disposeBag)
    }
}
