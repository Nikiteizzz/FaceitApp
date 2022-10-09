//
//  Game.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 9.10.22.
//

import Foundation

struct Game: Codable {
    var region: String
    var game_player_id: String
    var skill_level: Int
    var faceit_elo: Int
    var game_player_name: String
}
