//
//  Error.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import Foundation

struct Error: Codable {
    var message: String
    var code: String
    var http_status: String
    var parameters: String
}
