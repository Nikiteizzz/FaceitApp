//
//  UserData.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import Foundation

struct UserData: Codable {
    var avatar: String
    var country: String
    var nickname: String
    var steam_id_64: String
    var memberships: [String]
}
