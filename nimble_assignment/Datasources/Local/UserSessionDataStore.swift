//
//  AuthenicationLocalStorage.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation
import KeychainAccess
import PromiseKit

protocol UserSessionDataStore {
    func readUserSession() -> Promise<AuthenicationAttributes?>
    func save(userSession: AuthenicationAttributes) -> Promise<AuthenicationAttributes?>
    func delete()
}

class UserSessionDataStoreImpl: UserSessionDataStore {
    
    private let keychain = Keychain(
        service: Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    )
    
    func readUserSession() -> Promise<AuthenicationAttributes?> {
        return Promise() { seal in
            guard let data = keychain[data: Constants.authInfomation] else {
                seal.reject(CustomError.unauthorized)
                return
            }
           
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let decoder = JSONDecoder()
            let authInformation = try decoder.decode(AuthenicationAttributes.self, from: jsonData)
            seal.fulfill(authInformation)
        }
    }
    
    func save(userSession: AuthenicationAttributes) -> Promise<AuthenicationAttributes?> {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(userSession)
        keychain[data: Constants.authInfomation] = jsonData
        return self.readUserSession()
    }
    
    func delete() {
        keychain[data: Constants.authInfomation] = nil
    }
}
