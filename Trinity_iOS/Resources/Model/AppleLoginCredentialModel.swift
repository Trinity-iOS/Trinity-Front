//
//  AppleLoginCredentialModel.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/31/25.
//

import Foundation

struct AppleCredential: Equatable {
    let userID: String
    let email: String?
    let fullName: PersonNameComponents?
    let identityToken: String 
}
