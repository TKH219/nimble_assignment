//
//  SurveyListViewModel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation
import RxCocoa
import RxSwift

class SurveyListViewModel: BaseViewModel {
    
//    struct Input {
//        var getSurveyList: Driver<Void>
//        var loadMore: Driver<Void>
//        var onTakeSurvey: Driver<Survey>
//    }
//
//    struct Output {
//        var surveys: Driver<[Survey]>
//        var gotoSurveyDetails: Driver<Survey>
//        var canLoadMore: Driver<Bool>
//        var avatarUrl: Driver<URL>
//    }
//
    let surveys = BehaviorRelay<[Survey]>(value: [])
    private let pagination = BehaviorRelay<Metadata?>(value: nil)
    private lazy var surveyRepository = resolver.resolve(SurveyRepository.self)!
//    private lazy var userRepository = resolver.resolve(UserRepository.self)!

//    func transform(input: Input) -> Output {
//
//        userRepository
//            .getUserProfile()
//            .subscribe(onSuccess: { _ in })
//            .disposed(by: rx.disposeBag)
//
//        input.getSurveyList.drive(onNext: { [weak self] in
//            self?.getSurvey(loadMore: false)
//        }).disposed(by: rx.disposeBag)
//
//        input.loadMore.drive(onNext: { [weak self] in
//            self?.getSurvey(loadMore: true)
//        }).disposed(by: rx.disposeBag)
//
//        return Output(
//            surveys: surveys.asDriver(),
//            gotoSurveyDetails: input.onTakeSurvey,
//            canLoadMore: pagination
//                .compactMap { $0 }
//                .map { $0.canLoadMore }
//                .asDriverOnErrorJustComplete(),
//            avatarUrl: userRepository
//                .userObservable
//                .compactMap { $0?.avatarUrl }
//                .compactMap { URL(string: $0) }
//                .asDriverOnErrorJustComplete()
//        )
//    }
//
    func getSurvey(loadMore: Bool) {
        if !loadMore {
            self.pagination.accept(nil)
        }
        let page = (pagination.value?.page ?? 0) + 1
        surveyRepository
            .getListSurvey(page: page)
            .trackActivity(activityIndicator)
//            .retry(when: { [weak self] error in
//                return error.flatMapLatest { error -> Observable<Void> in
//                    guard let self = self, let errorResponse = error as? ErrorResponse,
//                          errorResponse == ErrorResponse.noInternetConnection else {
//                        return .error(error)
//
//                    }
//                    return self.connectivityService
//                        .onConnectStatusChanged
//                        .filter { $0 }
//                        .mapToVoid()
//                }
//            })
            .subscribe(onNext: { [weak self] (response: GetListSurveyResponse)  in
                guard let self = self else { return }
                let responseSurveys = response.data.map { element in
                    return element.attributes
                }
                let list = loadMore ? self.surveys.value + responseSurveys : responseSurveys
                self.surveys.accept(list)
                //                self.pagination.accept(response.metadata)
            }
//                       onFailure: { customError in
//                print(customError)
//            }
            )
//            .disposed(by: rx.disposeBag)
    }
}
