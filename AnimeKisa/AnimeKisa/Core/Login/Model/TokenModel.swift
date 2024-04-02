//
//  TokenModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 28/03/24.
//

import Foundation

struct TokenModel: Codable {
    var access_token: String
    var refresh_token: String
    var expires_in: Int
    var token_type: String

    enum CodingKeys: String, CodingKey {
        case access_token
        case refresh_token
        case expires_in
        case token_type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try container.decode(String.self, forKey: .access_token)
        refresh_token = try container.decode(String.self, forKey: .refresh_token)
        expires_in = try container.decode(Int.self, forKey: .expires_in)
        token_type = try container.decode(String.self, forKey: .token_type)
    }
}




