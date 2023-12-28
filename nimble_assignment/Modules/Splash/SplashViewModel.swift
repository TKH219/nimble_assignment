//
//  SplashViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import RxSwift

class SplashViewModel: BaseViewModel {
    public let loggedIn = BehaviorSubject<Bool>(value: false)
    
    func checkLoggedIn() {
        let userSession = resolver.resolve(UserSessionDataStore.self)?.readUserSession()
        if let _ = userSession {
            self.loggedIn.onNext(true)
        } else {
            self.loggedIn.onNext(false)
        }
    }
}
