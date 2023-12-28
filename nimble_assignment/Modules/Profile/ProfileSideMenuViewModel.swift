//
//  ProfileSideMenuViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileSideMenuViewModel: BaseViewModel {

//    struct Input {
//        let logout: Driver<Void>
//    }
//
//    struct Output {
//        let user: Driver<User>
//        let logoutSuccess: Driver<Void>
//    }
    
//    private lazy var userRepository = resolver.resolve(UserRepository.self)!
//    private lazy var authRepository = resolver.resolve(AuthRepository.self)!
//    private lazy var accessTokenProvider = resolver.resolve(AccessTokenProvider.self)!
    
    private let logoutSuccess = PublishSubject<Void>()

    
//    func transform(input: Input) -> Output {
//        input.logout.drive(onNext: { [weak self] in
//            guard let self = self else { return }
//            self.logout()
//        }).disposed(by: rx.disposeBag)
//
//        return Output(
//            user: userRepository
//                .userObservable
//                .compactMap { $0 }
//                .asDriverOnErrorJustComplete(),
//            logoutSuccess: logoutSuccess.asDriverOnErrorJustComplete()
//        )
//    }
    
    private func logout() {
        
//        if let token = accessTokenProvider.accessToken?.accessToken {
//            authRepository
//                .logout(token: token)
//                .subscribe(onSuccess: {}, onFailure: { _ in })
//                .disposed(by: rx.disposeBag)
//        }
//        self.accessTokenProvider.updateToken(token: nil)
//        self.userRepository.clearCurrentUser()
//        self.logoutSuccess.onNext(())
    }
}
