//
//  AppDelegate.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    static let assembler = Assembler([AppInjection()])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchStartPage()
        return true
    }
    
    private func launchStartPage() {
        window = UIWindow()
        let splashVC = AppDelegate.assembler.resolver.resolve(SplashViewController.self)!
        let nav = UINavigationController(rootViewController: splashVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

