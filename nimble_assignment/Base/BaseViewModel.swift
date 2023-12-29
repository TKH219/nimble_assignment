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
    
    public var errorMessages: Observable<String?> {
        return errorMessagesSubject.asObserver()
    }
    
    public let errorMessagesSubject = PublishSubject<String?>()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func errorHandler(_ errorMessage: String?) {
        errorMessagesSubject.onNext(errorMessage)
    }
}
