//
//  SurveyRepository.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//
import Foundation
import RxSwift

protocol SurveyRepository {
    func getListSurvey(page: Int) -> Single<GetListSurveyResponse>
}

