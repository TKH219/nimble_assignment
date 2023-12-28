//
//  BaseViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

class BaseViewModel: NSObject {
    
    let resolver: Resolver
    
    let activityIndicator = ActivityIndicator()
    
    public var errorMessages: Observable<CustomError> {
        return errorMessagesSubject.asObserver()
    }
    
    public let errorMessagesSubject = PublishSubject<CustomError>()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func errorHandler(_ error: Error) {
        if let error = error as? CustomError {
            errorMessagesSubject.onNext(error)
            return
        }
        
        errorMessagesSubject.onNext(CustomError.unknown)
    }
}
