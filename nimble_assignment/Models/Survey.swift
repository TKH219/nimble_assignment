//
//  Survey.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation

struct Survey: Decodable {
    var title: String
    var description: String
    var thankEmailAboveThreshold: String?
    var thankEmailBelowThreshold: String?
    var isActive: Bool
    var coverImageUrl: String
    var createdAt: String
    var activeAt: String
    var inactiveAt: String?
    var surveyType: String
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case description = "description"
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageUrl = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyType = "survey_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        thankEmailAboveThreshold = try values.decode(String?.self, forKey: .thankEmailAboveThreshold)
        thankEmailBelowThreshold = try values.decode(String?.self, forKey: .thankEmailBelowThreshold)
        isActive = try values.decode(Bool.self, forKey: .isActive)
        coverImageUrl = try values.decode(String.self, forKey: .coverImageUrl)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        activeAt = try values.decode(String.self, forKey: .activeAt)
        inactiveAt = try values.decode(String?.self, forKey: .inactiveAt)
        surveyType = try values.decode(String.self, forKey: .surveyType)
    }
}

extension Survey {
    func getHighResolutionCoverImageUrl() -> String {
        return "\(coverImageUrl)l"
    }
}
