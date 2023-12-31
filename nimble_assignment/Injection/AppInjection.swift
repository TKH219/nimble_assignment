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
        
        // MARK: Services
        container.register(UserSessionDataStore.self) { resolver in
            UserSessionDataStoreImpl()
        }
        
        container.register(AlamofireClient.self) { resolver in
            AlamofireClient(withBaseUrl: EnvironmentVariable.baseUrl, userSessionDataStore: resolver.resolve(UserSessionDataStore.self)!)
        }
        
        // MARK: Repository
        container.register(AuthenicationRepository.self) { resolver in
            AuthenicationRepositoryImpl(alamofireClient: resolver.resolve(AlamofireClient.self)!, userSessionDataStore: resolver.resolve(UserSessionDataStore.self)!)
        }.inObjectScope(.container)
        
        container.register(SurveyRepository.self) { resolver in
            SurveyRepositoryImpl(alamofireClient: resolver.resolve(AlamofireClient.self)!)
        }.inObjectScope(.container)
        
        // MARK: ViewController
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
        
        container.register(SurveyListViewController.self) { resolver in
            SurveyListViewController(
                viewModel: SurveyListViewModel(resolver: resolver),
                resolver: resolver
            )
        }

        container.register(SurveyDetailViewController.self) { resolver in
            SurveyDetailViewController(
                viewModel: SurveyDetailViewModel(resolver: resolver),
                resolver: resolver
            )
        }
    }
}
