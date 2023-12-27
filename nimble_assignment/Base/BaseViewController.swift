//
//  BaseViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import UIKit
import Swinject
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel: T
    let resolver: Resolver
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
     }
    
    private lazy var loadingActivity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(viewModel: T, resolver: Resolver) {
        self.viewModel = viewModel
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
        print("\(String(describing: self)) init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLoadingActivity() {
        view.addSubview(loadingActivity)
        loadingActivity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    var defaultLoadingAnimation: Bool {
        return true
    }

    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewToViewModel()
        observeErrorMessages()
        configLoadingActivity()
        bindViewModelToView()
    }
    

    func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else {
                  return
                }
                
                strongSelf.onError(error: errorMessage)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModelToView() {
        
    }
    
    func bindViewToViewModel() {
        guard viewModel != nil else { return }
//        viewModel
//            .loading
//            .asObservable()
//            .bind(to: isLoading)
//            .disposed(by: rx.disposeBag)
//        viewModel.error.drive(onNext: { [weak self] error in
//            self?.onError(error: error)
//        }).disposed(by: rx.disposeBag)
//        isLoading
//            .distinctUntilChanged()
//            .bind(onNext: { [weak self] loading in
//                guard let self = self else { return }
//                loading ? self.loadingActivity.startAnimating() : self.loadingActivity.stopAnimating()
//                self.loadingActivity.isHidden = !loading || !self.defaultLoadingAnimation
//            })
//            .disposed(by: rx.disposeBag)
       
    }
    
    func onError(error: Error) {
        if let error = error as? CustomError {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        if #available(iOS 11.0, *) {
            self.navigationItem.backButtonTitle = ""
        }
    }
}
