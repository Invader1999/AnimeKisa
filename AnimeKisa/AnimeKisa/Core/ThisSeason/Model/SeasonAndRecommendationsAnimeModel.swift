//
//  SeasonAnimeModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import Foundation
import UniqueID

struct SeasonAndRecommendationsAnimeModel: Codable, Hashable,Identifiable {
    
    var id:String? = UUID().uuidString
    let data: [Datum]?
    let paging: Paging?
    let season: Season?
}

struct Datum: Codable, Hashable,Identifiable {
    var id:String? = UUID().uuidString
    let node: Node?
}

struct Node: Codable, Hashable,Identifiable {
    var id: Int?
    let title: String?
    let mainPicture: MainPicture?

    enum CodingKeys: String, CodingKey {
        case id, title
        case mainPicture = "main_picture"
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MainPicture: Codable, Hashable {
    let medium, large: String?
}

struct Paging: Codable, Hashable {
}

struct Season: Codable, Hashable {
    let year: Int?
    let season: String?
}
