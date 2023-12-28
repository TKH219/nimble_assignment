//
//  GetListSurveyResponse.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation

struct GetListSurveyResponse: Decodable {
    var metadata: Metadata
    var data: [BaseResponse<Survey>]
    
    enum CodingKeys : String, CodingKey {
        case data = "data"
        case metadata = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([BaseResponse<Survey>].self, forKey: .data)
        metadata = try values.decode(Metadata.self, forKey: .metadata)
    }
}

