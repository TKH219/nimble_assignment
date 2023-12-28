//
//  AlamofireRequestInterceptor.swift
//  nimble_assignment
//
//  Created by Trần Hà on 29/12/2023.
//

import Foundation
import Alamofire

class AlamofireRequestInterceptor: RequestInterceptor {
    
    private let storage: UserSessionDataStore
    private var isRefreshing = false
    
    init(storage: UserSessionDataStore) {
        self.storage = storage
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Swift.Result<URLRequest, Swift.Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(EnvironmentVariable.baseUrl) == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + (self.storage.readUserSession()?.accessToken ?? ""), forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Swift.Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        
        refreshToken { [weak self] (isSuccess, response) in
            guard let self = self, let attributes = response?.data.attributes else { return }
            
            if (isSuccess) {
                self.storage.save(userSession: attributes)
                completion(.retry)
            } else {
                completion(.doNotRetryWithError(error))
            }
        }
    }
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ loginResponse: LoginResponse?) -> Void
    
    private func refreshToken(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        let urlString = "\(EnvironmentVariable.baseUrl)oauth/token"
        let params = [
            "grant_type": "refresh_token",
            "refresh_token": self.storage.readUserSession()?.refreshToken ?? "",
            "client_id": EnvironmentVariable.clientId,
            "client_secret": EnvironmentVariable.clientSecret
        ]
        
        AF.request(urlString,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: [:])
        .responseData { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                    if !JSONSerialization.isValidJSONObject(jsonObject) {
                        completion(false, nil)
                    }
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LoginResponse.self, from: jsonData)
                    completion(true, response)
                } catch {
                    completion(false, nil)
                }
            case .failure(_):
                completion(false, nil)
            }
            
            strongSelf.isRefreshing = false
        }
    }
}
