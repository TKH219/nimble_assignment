//
//  File.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation

enum CustomError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case invalidJson
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .unknown, .invalidJson:
            return "General Error"
        }
    }
}
