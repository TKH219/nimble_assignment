//
//  AlamofireClient.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation
import Alamofire
import RxSwift
import PromiseKit

class AlamofireClient: NSObject {
    
    var baseUrl:String = ""
    
    init(withBaseUrl:String) {
        super.init()
        baseUrl = withBaseUrl
    }
    
    public func request<T: Decodable>(method: HTTPMethod,path: String, params: Dictionary<String, Any>) -> Promise<T> {
        return Promise { seal in
            let urlString: String = "\(self.baseUrl)\(path)"
            let url =  URL(string: urlString)!
            
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: self.createHeaderRequest())
                .validate(contentType: ["application/json"])
                .responseData { response in
                    print(response)
                    switch response.result {
                    case .success(let data):
                        do {
                            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                            if !JSONSerialization.isValidJSONObject(jsonObject) {
                                return seal.reject(CustomError.invalidJson)
                            }
                            
                            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(T.self, from: jsonData)
                            seal.fulfill(response)
                        } catch {
                            seal.reject(CustomError.invalidJson)
                        }
                    case .failure(_):
                        let errorEnum = self.errorHandle(statusCode: response.response?.statusCode)
                        return seal.reject(errorEnum)
                    }
                }
        }
    }
    
    func createHeaderRequest() -> HTTPHeaders {
        return HTTPHeaders([:])
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
