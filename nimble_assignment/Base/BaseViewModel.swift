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
    
//    let loading = ActivityIndicator()

//    let error = ErrorTracker()
    
    public var errorMessages: Observable<CustomError> {
        return errorMessagesSubject.asObserver()
    }
    
    public let errorMessagesSubject = PublishSubject<CustomError>()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }

}
