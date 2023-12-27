//
//  LoginResponse.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

//import Foundation
//
//struct LoginResponse: Codable {
//    var id: String?
//    var type: String?
//    var attributes: AuthenicationAttributes?
//}

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

//struct LoginResponseInformation: Decodable {
//    var id: String
//    var type: String
//    var attributes: AuthenicationAttributes
//
//    enum CodingKeys : String, CodingKey {
//        case id = "id"
//        case type = "type"
//        case attributes = "attributes"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        type = try values.decode(String.self, forKey: .type)
//        attributes = try values.decode(AuthenicationAttributes.self, forKey: .attributes)
//    }
//}



