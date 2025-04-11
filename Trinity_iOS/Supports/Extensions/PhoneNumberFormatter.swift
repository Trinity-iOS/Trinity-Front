//
//  PhoneNumberFormatter.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/11/25.
//

import Foundation

struct PhoneNumberFormatter {
    static func formatted(for country: Country, rawNumber: String) -> String {
        let trimmed = rawNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let noLeadingZero = trimmed.hasPrefix("0") ? String(trimmed.dropFirst()) : trimmed
        return country.code + noLeadingZero
    }
}
