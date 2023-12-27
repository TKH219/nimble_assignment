//
//  AuthenicationAttributes.swift
//  nimble_assignment
//
//  Created by Trần Hà on 25/12/2023.
//

import Foundation

struct AuthenicationAttributes: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var refreshToken: String
    var createdAt: Date
    
    enum CodingKeys : String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(tokenType, forKey: .tokenType)
        try container.encode(expiresIn, forKey: .expiresIn)
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode(createdAt, forKey: .createdAt)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        expiresIn = try values.decode(Int.self, forKey: .expiresIn)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
    }
}
