//
//  LoginResponse.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation

struct LoginResponse: Decodable {
    var data: BaseResponse<AuthenicationAttributes>
    
    enum CodingKeys : String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(BaseResponse<AuthenicationAttributes>.self, forKey: .data)
    }
}
