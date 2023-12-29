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

        var container: Container!
        var isLoginSuccess: Bool?
        var isLoginError: String?
        var viewModel: LoginViewModel!
        var disposeBag: DisposeBag!

        describe("LoginViewModelSpecs") {
            
            beforeEach {
                container = self.setupContainer()
                viewModel = LoginViewModel(resolver: container)
                disposeBag = DisposeBag()
    
                viewModel.loginSuccess.asDriver(onErrorJustReturn: false).drive { isSuccess in
                    isLoginSuccess = isSuccess
                }.disposed(by: disposeBag)
                
                viewModel.errorMessages.asDriver(onErrorJustReturn: CustomError.unknown.localizedDescription).drive { customErrorMessage in
                    isLoginError = customErrorMessage
                }.disposed(by: disposeBag)
            }
            
            afterEach {
                viewModel = nil
                disposeBag = nil
                isLoginSuccess = nil
                isLoginError = nil
            }
            
            func updateEmailAndPasswordInput(_ email: String, _ password: String) {
                viewModel.emailInput.onNext(email)
                viewModel.passwordInput.onNext(password)
            }
            
            context("validate email and password") {
                
                it("empty email - expected fail") {
                    updateEmailAndPasswordInput("", "this is password")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("invalid email - expected fail") {
                    updateEmailAndPasswordInput("this is an wrong email", "this is password")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("empty password - expected fail") {
                    updateEmailAndPasswordInput("validEmail@email.com", "")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
                
                it("valid email and password - expected login success") {
                    updateEmailAndPasswordInput("validEmail@email.com", "validPassword")
                    viewModel.signIn()
                    expect(isLoginError).to(beNil())
                    expect(isLoginSuccess).to(beTrue())
                }
            }
            
            context("login with invalid credentials") {
                
                it("expected error") {
                    updateEmailAndPasswordInput("wrong@email.com", "wrongPassword")
                    viewModel.signIn()
                    expect(isLoginSuccess).to(beFalse())
                    expect(isLoginError).notTo(beNil())
                }
            }
            
            context("login with valid credentials") {
                
                it("expected login successful") {
                    updateEmailAndPasswordInput("validEmail@email.com", "validPassword")
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
