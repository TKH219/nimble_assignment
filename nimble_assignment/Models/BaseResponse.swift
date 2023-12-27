//
//  BaseResponse.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var id: String
    var type: String
    var attributes: T
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
        attributes = try values.decode(T.self, forKey: .attributes)
    }
}
