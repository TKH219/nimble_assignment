//
//  SplashViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import UIKit
import SnapKit

class SplashViewController: BaseViewController<SplashViewModel> {
//    private lazy var backgroundImageView = UIImageView(asset: .splash_screen_2)
//    private lazy var logoImageView = UIImageView(asset: .nimble_lo)
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"splash_screen_background")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"nimble_logo_white")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func setupView() {
    
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logoImageView)
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.height.equalTo(frameScreen.height)
            make.width.equalTo(frameScreen.width)
        }
        
        self.logoImageView.snp.makeConstraints { make in
            make.center.equalTo(self.backgroundImageView)
        }
    }
    
    override func bindViewToViewModel() {
        super.bindViewToViewModel()
//        guard let viewModel = viewModel as? SplashViewModel else {
//            return
//        }
//        let input = SplashViewModel.Input(trigger: Driver.just(()))
//        let output = viewModel.transform(input: input)
//        output.gotoLogin.drive(onNext: { [weak self] in
//            guard let self = self else { return }
//            self.navigationController?.setViewControllers(
//                [self.resolver.resolve(LoginViewController.self)!],
//                animated: false
//            )
//        }).disposed(by: rx.disposeBag)
//
//        output.gotoSurveyList.drive(onNext: { [weak self] in
//            guard let self = self else { return }
//            self.navigationController?.setViewControllers(
//                [self.resolver.resolve(SurveyListViewController.self)!],
//                animated: false
//            )
//        }).disposed(by: rx.disposeBag)
    }
}
