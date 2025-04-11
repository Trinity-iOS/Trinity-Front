//
//  Country.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import Foundation

struct Country: Equatable, Identifiable, Hashable {
    var id: String { code }
    let name: String
    let code: String
    let flag: String
    let minimumLength: Int

    static let `default` = Country(name: "South Korea", code: "+82", flag: "🇰🇷", minimumLength: 9)
}
