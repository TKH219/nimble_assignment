//
//  MockAuthenicationRepository.swift
//  nimble_assignmentTests
//
//  Created by Trần Hà on 29/12/2023.
//

import Quick
import Nimble
import Swinject
import RxSwift

@testable import nimble_assignment

class MockAuthenicationRepository: AuthenicationRepository {
    func signIn(email: String, password: String) -> Single<Bool> {
        return Single<Bool>.create { single in
            if (email == "validEmail@email.com" && password == "validPassword") {
                single(.success(true))
            } else {
                single(.failure(CustomError.badRequest))
            }
            
            return Disposables.create {}
        }
    }
}
