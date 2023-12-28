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

    override func bindViewModel() {
        super.bindViewModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.viewModel.checkLoggedIn()
            self.viewModel
                .loggedIn
                .asDriver(onErrorJustReturn: false)
                .distinctUntilChanged()
                .drive(onNext: { [weak self] isSuccess in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if (isSuccess) {
                        strongSelf.navigationController?.setViewControllers(
                            [strongSelf.resolver.resolve(SurveyListViewController.self)!],
                            animated: false
                        )
                    } else {
                        strongSelf.navigationController?.setViewControllers(
                            [strongSelf.resolver.resolve(LoginViewController.self)!],
                            animated: false
                        )
                    }
                })
                .disposed(by: self.rx.disposeBag)
        })
    }
}
