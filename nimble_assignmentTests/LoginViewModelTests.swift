//
//  LoginViewModelTests.swift
//  nimble_assignmentTests
//
//  Created by Trần Hà on 29/12/2023.
//

import Quick
import Nimble
import Swinject
import RxSwift

@testable import nimble_assignment
class LoginViewModelTests: QuickSpec {
    
    override func spec() {

        var email: BehaviorSubject<String>!
        var password: BehaviorSubject<String>!
        var container: Container!
        var isLoginSuccess: Bool?
        var isLoginError: Error?
        var viewModel: LoginViewModel!
        var disposeBag: DisposeBag!

        describe("LoginViewModelSpecs") {
            
            beforeEach {
                email = BehaviorSubject<String>(value: "")
                password = BehaviorSubject<String>(value: "")
                container = self.setupContainer()
                viewModel = LoginViewModel(resolver: container)
                disposeBag = DisposeBag()
    
                viewModel.loginSuccess.asDriver(onErrorJustReturn: false).drive { isSuccess in
                    isLoginSuccess = isSuccess
                }.disposed(by: disposeBag)
                
                viewModel.errorMessages.asDriver(onErrorJustReturn: CustomError.unknown).drive { customError in
                    isLoginError = customError
                }.disposed(by: disposeBag)
            }
            
            afterEach {
                viewModel = nil
                disposeBag = nil
                isLoginSuccess = nil
                isLoginError = nil
            }
            
            context("validate email and password") {
                
                it("empty email - expected fail") {
                    email.onNext("")
                    password.onNext("not an empty string")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("invalid email - expected fail") {
                    email.onNext("this is an invalid email")
                    password.onNext("not an empty string")
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("empty password - expected fail") {
                    email.onNext("validEmail@email.com")
                    password.onNext("")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("valid email and password - expected login success") {
                    email.onNext("correct@email.com")
                    password.onNext("correctPassword")
                    viewModel.signIn()
                    expect(isLoginError).to(beNil())
                    expect(isLoginSuccess).to(beTrue())
                }
            }
            
            context("login with invalid credentials") {
                
                it("expected error") {
                    email.onNext("wrong@email.com")
                    password.onNext("wrongPassword")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
            }
            
            context("login with valid credentials") {
                
                it("expected login successful") {
                    email.onNext("validEmail@email.com")
                    password.onNext("validPassword")
                    viewModel.signIn()
                    expect(isLoginError).to(beNil())
                    expect(isLoginSuccess).to(beTrue())
                }
            }
        }
    }
    
    private func setupContainer() -> Container {
        let container = Container()
        container.register(AuthenicationRepository.self) { r in
            MockAuthenicationRepository()
        }
        return container
    }
}
