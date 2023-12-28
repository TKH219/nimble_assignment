//
//  DateExtensions.swift
//  nimble_assignment
//
//  Created by Trần Hà on 29/12/2023.
//

import Foundation

public extension Date {
    func string(usingFormat format: String, usingTimeZone timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
