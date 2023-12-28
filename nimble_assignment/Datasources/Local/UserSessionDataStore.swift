//
//  AuthenicationLocalStorage.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation
import KeychainAccess
import RxSwift

protocol UserSessionDataStore {
    func readUserSession() -> AuthenicationAttributes?
    func save(userSession: AuthenicationAttributes)
    func delete()
}

class UserSessionDataStoreImpl: UserSessionDataStore {
    
    private let keychain = Keychain(
        service: Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    )
    
    func readUserSession() -> AuthenicationAttributes? {
        guard let data = self.keychain[data: Constants.authInfomation] else {
            return nil
        }
        
//        var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
//        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//        let decoder = JSONDecoder()
//        let authInformation = try? decoder.decode(AuthenicationAttributes.self, from: jsonData)
//        return authInformation
        
//        return Single<AuthenicationAttributes?>.create { seal in
//            guard let data = self.keychain[data: Constants.authInfomation] else {
//                seal(.failure(CustomError.unauthorized))
//                return Disposables.create {}
//            }
//
            do {
                var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let authInformation = try? decoder.decode(AuthenicationAttributes.self, from: jsonData)
                return authInformation
//                seal(.success(authInformation))
            } catch {
                return nil
//                seal(.failure(CustomError.notFound))
            }
//
//            return Disposables.create {}
//        }
    }
    
    func save(userSession: AuthenicationAttributes) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(userSession)
        keychain[data: Constants.authInfomation] = jsonData
//        return self.readUserSession()
    }
    
    func delete() {
        keychain[data: Constants.authInfomation] = nil
    }
}
