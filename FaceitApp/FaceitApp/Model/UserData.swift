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
    var steamID64: String
    var memberships: [String]
    var games: [String : Game]
    enum CodingKeys: String, CodingKey {
        case avatar
        case country
        case nickname
        case steamID64 = "steam_id_64"
        case memberships
        case games
    }
}
