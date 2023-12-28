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
import RxCocoa

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel: T
    let resolver: Resolver
    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<Error>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
     }
    
    private lazy var loadingActivity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        return activity
    }()
    
    init(viewModel: T, resolver: Resolver) {
        self.viewModel = viewModel
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewToViewModel()
        observeErrorMessages()
        bindViewModelToView()
        configLoadingActivity()
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
    
    private func configLoadingActivity() {
        view.addSubview(loadingActivity)
        loadingActivity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    func observeErrorMessages() {

    }
    
    func bindViewModelToView() {
        viewModel
            .activityIndicator
            .asObservable()
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        isLoading
            .distinctUntilChanged()
            .bind(onNext: { [weak self] loading in
                guard let self = self else { return }
                print(loading)
                self.loadingActivity.isHidden = !loading
                if (loading) {
//                    self.showAlert(title: "Error", message: "error.localizedDescription")
                    self.loadingActivity.startAnimating()
                } else {
                    self.loadingActivity.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] customErrorMessage in
                guard let strongSelf = self else {
                  return
                }
                
                strongSelf.onError(customErrorMessage)
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewToViewModel() {


//        viewModel.error.drive(onNext: { [weak self] error in
//            self?.onError(error: error)
//        }).disposed(by: rx.disposeBag)

        
    }
    
    func onError(_ customError: CustomError) {
        showAlert(title: "Error \(customError.rawValue)", message: customError.localizedDescription)
    }
}
