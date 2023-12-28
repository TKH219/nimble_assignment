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
                "client_id": "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw",
                "client_secret": "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw"
            ]
            
            
            self.alamofireClient
                .request(method: .post, path: "oauth/token", params: params)
                .subscribe(
                    onSuccess: {(responseData: LoginResponse) in
                        print("JSON: ", responseData)
                        self.userSessionDataStore.save(userSession: responseData.data.attributes)
                        single(.success(true))
                    },
                    onFailure: { error in
                        print("AuthenicationRepositoryImpl Error: ", error)
                        single(.failure(error))
                    })
            
            return Disposables.create {}
        }
    }
    
//    func logout(token: String) -> RxSwift.Single<Void> {
//
//    }
    
    
}
