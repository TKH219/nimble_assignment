//
//  Metadata.swift
//  nimble_assignment
//
//  Created by Trần Hà on 27/12/2023.
//

import Foundation

struct Metadata: Decodable {
    var page: Int
    var pages: Int
    var pageSize: Int
    var record: Int
    
    enum CodingKeys : String, CodingKey {
        case page = "page"
        case pages = "pages"
        case pageSize = "page_size"
        case record = "records"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        pages = try values.decode(Int.self, forKey: .pages)
        pageSize = try values.decode(Int.self, forKey: .pageSize)
        record = try values.decode(Int.self, forKey: .record)
    }
}
