//
//  AppInjection.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import Swinject

class AppInjection: Assembly {
    
    func assemble(container: Container) {
        
        container.register(AlamofireClient.self) { resolver in
            AlamofireClient(withBaseUrl: Constants.baseUrl)
        }
        
        container.register(UserSessionDataStore.self) { resolver in
            UserSessionDataStoreImpl()
        }
        
        container.register(AuthenicationRepository.self) { resolver in
            AuthenicationRepositoryImpl(alamofireClient: resolver.resolve(AlamofireClient.self)!)
        }.inObjectScope(.container)
        
        container.register(SurveyRepository.self) { resolver in
            SurveyRepositoryImpl(alamofireClient: resolver.resolve(AlamofireClient.self)!)
        }.inObjectScope(.container)
        
        container.register(SplashViewController.self) { resolver in
            SplashViewController(
                viewModel: SplashViewModel(resolver: resolver),
                resolver: resolver
            )
        }
    
        container.register(LoginViewController.self) { resolver in
            LoginViewController(
                viewModel: LoginViewModel(resolver: resolver),
                resolver: resolver
            )
        }
        
//        container.register(SurveyListViewController.self) { resolver in
//            SurveyListViewController(
//                viewModel: SurveyListViewModel(resolver: resolver),
//                resolver: resolver
//            )
//        }
//
//        container.register(SurveyDetailViewController.self) { (resolver, survey) in
//            SurveyDetailViewController(
//                viewModel: nil,
//                resolver: resolver,
//                survey: survey
//            )
//        }
    }
}
