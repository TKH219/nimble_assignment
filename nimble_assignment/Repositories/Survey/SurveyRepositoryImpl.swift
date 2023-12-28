//
//  SurveyRepositoryImpl.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation
import RxSwift

class SurveyRepositoryImpl: SurveyRepository {
    
    private let alamofireClient: AlamofireClient
    
    init(alamofireClient: AlamofireClient) {
        self.alamofireClient = alamofireClient
    }
    
    func getListSurvey(page: Int) -> Single<GetListSurveyResponse> {
        let params = [
            "page[number]": page,
            "page[size]": Constants.totalItems
        ]
        
        return self.alamofireClient.request(method: .get, path: "surveys", params: params)
    }
}
