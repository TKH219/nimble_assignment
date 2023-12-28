//
//  AuthenicationRepositoryImpl.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation
import Swinject
import RxSwift

class AuthenicationRepositoryImpl: AuthenicationRepository {
    
    private let alamofireClient: AlamofireClient
    private let userSessionDataStore: UserSessionDataStore
    
    let disposeBag = DisposeBag()
    
    init(alamofireClient: AlamofireClient, userSessionDataStore: UserSessionDataStore) {
        self.alamofireClient = alamofireClient
        self.userSessionDataStore = userSessionDataStore
    }
    
    func signIn(email: String, password: String) -> Single<Bool> {
        return Single<Bool>.create { single in
            let params = [
                "email": email,
                "password": password,
                "grant_type": "password",
                "client_id": EnvironmentVariable.clientId,
                "client_secret": EnvironmentVariable.clientSecret
            ]
            
            
            self.alamofireClient
                .request(method: .post, path: "oauth/token", params: params)
                .subscribe(
                    onSuccess: {(responseData: LoginResponse) in
                        self.userSessionDataStore.save(userSession: responseData.data.attributes)
                        single(.success(true))
                    },
                    onFailure: { error in
                        single(.failure(error))
                    }
                )
            
                .disposed(by: self.disposeBag)
            
            return Disposables.create {}
        }
    }
    
//    func logout(token: String) -> RxSwift.Single<Void> {
//
//    }
}
