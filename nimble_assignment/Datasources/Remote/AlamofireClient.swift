//
//  AlamofireClient.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation
import Alamofire
import RxSwift

class AlamofireClient: NSObject {
    
    var baseUrl: String = ""
    
    private let userSessionDataStore: UserSessionDataStore
    var alamofireRequestInterceptor: AlamofireRequestInterceptor
    init(withBaseUrl:String, userSessionDataStore: UserSessionDataStore) {
        self.userSessionDataStore = userSessionDataStore
        self.baseUrl = withBaseUrl
        self.alamofireRequestInterceptor = AlamofireRequestInterceptor(storage: userSessionDataStore)
    }
    
    public func request<T: Decodable>(
        method: HTTPMethod,
        path: String,
        params: Dictionary<String, Any>) -> Single<T> {
        return Single<T>.create { [weak self] single in
            guard let self = self else { return Disposables.create {} }
            let urlString: String = "\(self.baseUrl)\(path)"
            let url =  URL(string: urlString)!
            let task = AF.request(url,
                                  method: method,
                                  parameters: params,
                                  encoding: URLEncoding.default,
                                  interceptor: self.alamofireRequestInterceptor)
                .validate(contentType: ["application/json"])
                .validate(statusCode: [200])
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                            single(.success(data))
                    case .failure(_):
                        let errorEnum = self.errorHandle(statusCode: response.response?.statusCode)
                        single(.failure(errorEnum))
                    }
                }
            
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    func errorHandle(statusCode: Int?) -> CustomError {
        switch (statusCode) {
        case CustomError.badRequest.rawValue:
            return CustomError.badRequest
        case CustomError.forbidden.rawValue:
            return CustomError.badRequest
        case CustomError.unauthorized.rawValue:
            return CustomError.unauthorized
        case CustomError.notFound.rawValue:
            return CustomError.notFound
        default:
            return CustomError.unknown
        }
    }
}
