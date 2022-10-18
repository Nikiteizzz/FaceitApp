//
//  Game.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 9.10.22.
//

import Foundation

struct Game: Codable {
    var region: String
    var gamePlayerId: String
    var skillLevel: Int
    var faceitElo: Int
    var gamePlayerName: String
    enum CodingKeys: String, CodingKey {
        case region
        case gamePlayerId = "game_player_id"
        case skillLevel = "skill_level"
        case faceitElo = "faceit_elo"
        case gamePlayerName = "game_player_name"
    }
}
