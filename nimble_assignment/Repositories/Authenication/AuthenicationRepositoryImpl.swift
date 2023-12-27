//
//  AuthenicationRepositoryImpl.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation
import Swinject
import RxSwift
import PromiseKit

class AuthenicationRepositoryImpl: AuthenicationRepository {
    
    private let alamofireClient: AlamofireClient
    private let userSessionDataStore: UserSessionDataStore
    
    init(alamofireClient: AlamofireClient, userSessionDataStore: UserSessionDataStore) {
        self.alamofireClient = alamofireClient
        self.userSessionDataStore = userSessionDataStore
    }

    func signIn(email: String, password: String) -> Promise<LoginResponse> {
        let params = [
            "email": email,
            "password": password,
            "grant_type": "password",
            "client_id": "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw",
            "client_secret": "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw"
        ]
        
        return alamofireClient.request(method: .post, path: "oauth/token", params: params)
    }
    
//    func logout(token: String) -> RxSwift.Single<Void> {
//
//    }
    
    
}
