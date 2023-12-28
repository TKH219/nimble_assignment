//
//  SurveyListViewController.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SideMenu

class SurveyListViewController: BaseViewController<SurveyListViewModel> {
    
    private let onTakeSurvey = PublishSubject<Survey>()
    private let onPageChanged = BehaviorSubject<Int>(value: 0)
    
    lazy var nextButton: RoundedButton = {
        let button = RoundedButton(imageString: "circle_button")
        button.addTarget(self, action: #selector(onTapNextButton), for: .touchUpInside)
        return button
    }()
    
    lazy var profileButton: RoundedButton = {
        let button = RoundedButton(imageString: "user_profile")
        button.addTarget(self, action: #selector(showProfileMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var dateTimeTitle: TitleLabel = {
        var titleString = Date().string(usingFormat: DateTimeFormat.EEEE_MMMM_D).uppercased()
        let label = TitleLabel(titleString: titleString)
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var todayTitle: TitleLabel = {
        let label = TitleLabel(titleString: "Today")
        label.font = .boldSystemFont(ofSize: 34)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.register(
            SurveyCollectionViewCell.self,
            forCellWithReuseIdentifier: SurveyCollectionViewCell.identifier
        )
        collectionView.rx
            .didScroll
            .withLatestFrom(collectionView.rx.contentOffset)
            .map { point in
                Int(point.x/UIScreen.main.bounds.width)
            }.bind(to: pageControl.rx.currentPage)
            .disposed(by: rx.disposeBag)
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = .white
        if #available(iOS 14.0, *) {
          pageControl.backgroundStyle = .minimal
          pageControl.allowsContinuousInteraction = false
        }
        pageControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.collectionView.scrollToItem(
                    at: IndexPath(
                        row: self.pageControl.currentPage,
                        section: 0
                    ),
                    at: .left,
                    animated: true
                )
            })
            .disposed(by: rx.disposeBag)
        return pageControl
    }()

    override func setupView() {
        super.setupView()
        view.addSubview(collectionView)
        view.addSubview(profileButton)
        view.addSubview(dateTimeTitle)
        view.addSubview(todayTitle)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        profileButton.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(45)
            } else {
                make.top.equalToSuperview().offset(45)
            }
            make.right.equalToSuperview().offset(-20)
        }

        dateTimeTitle.snp.makeConstraints { make in
            make.centerY.equalTo(profileButton)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(profileButton.snp.left).offset(-20)
            make.right.equalTo(profileButton.snp.left).offset(-20)
        }

        todayTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(dateTimeTitle.snp.bottom).offset(4)
        }
        
        pageControl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-170)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-54)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.getSurvey()
        viewModel.surveys.asDriver().drive(
            collectionView.rx.items(
                cellIdentifier: SurveyCollectionViewCell.identifier,
                cellType: SurveyCollectionViewCell.self
            )) {(index, value, cell) in
                cell.bindData(survey: value)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel.surveys
            .map { $0.count }
            .asDriver(onErrorJustReturn: 0)
            .drive(pageControl.rx.numberOfPages)
            .disposed(by: rx.disposeBag)
    }

    @objc private func showProfileMenu() {
        let sideMenuVC = ProfileSideMenuViewController(viewModel: ProfileSideMenuViewModel(resolver: resolver), resolver: resolver)
        sideMenuVC.onLogoutSuccess = { [weak self] in
            self?.navigationController?.dismiss(animated: false)
            self?.backToLogin()
        }
        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu.presentationStyle = .menuSlideIn
        self.present(menu, animated: true, completion: nil)
    }

    @objc private func onTapNextButton() {
        self.present(self.resolver.resolve(SurveyDetailViewController.self)!, animated: true, completion: nil)
    }
    
    private func backToLogin() {
        let loginVC = resolver.resolve(LoginViewController.self)!
        self.navigationController?.setViewControllers([loginVC], animated: true)
    }
}
