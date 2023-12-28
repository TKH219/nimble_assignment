//
//  AuthenicationRepository.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation
import RxSwift
import PromiseKit

protocol AuthenicationRepository {
    func signIn(email: String, password: String) -> Single<Bool>
//    func logout(token: String) -> Single<Void>
}

