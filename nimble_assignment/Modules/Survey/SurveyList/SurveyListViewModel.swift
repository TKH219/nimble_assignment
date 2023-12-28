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
    let surveys = BehaviorRelay<[Survey]>(value: [])
    private lazy var surveyRepository = resolver.resolve(SurveyRepository.self)!
    func getSurvey() {
        surveyRepository
            .getListSurvey(page: 1)
            .trackActivity(activityIndicator)
            .subscribe(
                onNext: { [weak self] (response: GetListSurveyResponse)  in
                    guard let self = self else { return }
                    let responseSurveys = response.data.map { element in
                        return element.attributes
                    }
                    
                    self.surveys.accept(responseSurveys)
                },
                onError: { (error) in
                    self.errorHandler(error)
                }
            )
            .disposed(by: rx.disposeBag)
    }
}
