//
//  SeasonAnimeModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//

import Foundation
import UniqueID
struct SeasonAndRecommendationsAnimeModel: Codable {
    var id:UniqueID? = UniqueID.random()
    //var id:String? = UUID().uuidString
    let data: [Datum]?
    let paging: Paging?
    let season: Season?
}

// MARK: - Datum
struct Datum: Codable {
    var id:UniqueID? = UniqueID.random()
    let node: Node?
}

// MARK: - Node
struct Node: Codable {
    let id: Int?
    let title: String?
    let mainPicture: MainPicture?

    enum CodingKeys: String, CodingKey {
        case id, title
        case mainPicture = "main_picture"
    }
}

// MARK: - MainPicture
struct MainPicture: Codable {
    let medium, large: String?
}

// MARK: - Paging
struct Paging: Codable {
}

// MARK: - Season
struct Season: Codable {
    let year: Int?
    let season: String?
}

