//
//  DateHandler.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 22/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation

enum DateError: String, Error {
    case invalidDate
}

class DateHandler {
    public static let dateDecoding: (Decoder) -> Date = { (decoder) -> Date in
        do {
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            } else {
                throw DateError.invalidDate
            }
        } catch {
            print("error parsing date")
        }
        return Date()
    }
}

