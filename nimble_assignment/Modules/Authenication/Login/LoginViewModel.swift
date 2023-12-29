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
    
    func validation() -> Bool {
        let (email, password) = getEmailPassword()
        return Validator.isValidEmail(email) && Validator.isValidPassword(password)
    }
    
    @objc
    public func signIn() {
        
        let isValid = validation()
        
        if (!isValid) {
            self.errorHandler("Invalid email or password.\nPlease check it again")
            return
        }
        
        let (email, password) = getEmailPassword()
        resolver.resolve(AuthenicationRepository.self)!
            .signIn(email: email, password: password)
            .trackActivity(activityIndicator)
            .subscribe(
                onNext: {(response) in
                    self.loginSuccess.onNext(true)
                },
                onError: { (error) in
                    self.handleErrorMessage(error)
                })
            .disposed(by: rx.disposeBag)
    }
    
    func handleErrorMessage(_ error: Error) {
        if let error = error as? CustomError {
            switch (error) {
            case .badRequest:
                self.errorHandler("Your email or password is incorrect.\nPlease try again.")
                break
            default:
                self.errorHandler(error.localizedDescription)
                break
            }
            
            return
        }
        
        super.errorHandler(error.localizedDescription)
    }
}
