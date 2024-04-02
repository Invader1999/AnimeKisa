//
//  AnimeDetailsModel.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//


import Foundation

struct AnimeDetailsModel: Codable {
    let id: Int
    let title: String
    let mainPicture: AnimeDetailsPicture
    let alternativeTitles: AnimeDetailsAlternativeTitles
    let startDate, endDate, synopsis: String
    let mean: Double
    let rank, popularity, numListUsers, numScoringUsers: Int
    let nsfw: String
    let createdAt, updatedAt: Date
    let mediaType, status: String
    let genres: [AnimeDetailsGenre]
    let numEpisodes: Int
    let startSeason: AnimeDetailsStartSeason
    let broadcast: AnimeDetailsBroadcast
    let source: String
    let averageEpisodeDuration: Int
    let rating: String
    let pictures: [AnimeDetailsPicture]
    let background: String
    let relatedAnime: [AnimeDetailsRelatedAnime]
    let relatedManga: [AnimeDetailsJSONAny]
    let recommendations: [AnimeDetailsRecommendation]
    let studios: [AnimeDetailsGenre]
    let statistics: AnimeDetailsStatistics

    enum CodingKeys: String, CodingKey {
        case id, title
        case mainPicture = "main_picture"
        case alternativeTitles = "alternative_titles"
        case startDate = "start_date"
        case endDate = "end_date"
        case synopsis, mean, rank, popularity
        case numListUsers = "num_list_users"
        case numScoringUsers = "num_scoring_users"
        case nsfw
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mediaType = "media_type"
        case status, genres
        case numEpisodes = "num_episodes"
        case startSeason = "start_season"
        case broadcast, source
        case averageEpisodeDuration = "average_episode_duration"
        case rating, pictures, background
        case relatedAnime = "related_anime"
        case relatedManga = "related_manga"
        case recommendations, studios, statistics
    }
}

// MARK: - AlternativeTitles
struct AnimeDetailsAlternativeTitles: Codable {
    let synonyms: [String]
    let en, ja: String
}

// MARK: - Broadcast
struct AnimeDetailsBroadcast: Codable {
    let dayOfTheWeek, startTime: String

    enum CodingKeys: String, CodingKey {
        case dayOfTheWeek = "day_of_the_week"
        case startTime = "start_time"
    }
}

// MARK: - Genre
struct AnimeDetailsGenre: Codable {
    let id: Int
    let name: String
}

// MARK: - Picture
struct AnimeDetailsPicture: Codable {
    let medium, large: String
}

// MARK: - Recommendation
struct AnimeDetailsRecommendation: Codable {
    let node: AnimeDetailsNode
    let numRecommendations: Int

    enum CodingKeys: String, CodingKey {
        case node
        case numRecommendations = "num_recommendations"
    }
}

// MARK: - Node
struct AnimeDetailsNode: Codable {
    let id: Int
    let title: String
    let mainPicture: AnimeDetailsPicture

    enum CodingKeys: String, CodingKey {
        case id, title
        case mainPicture = "main_picture"
    }
}

// MARK: - RelatedAnime
struct AnimeDetailsRelatedAnime: Codable {
    let node: AnimeDetailsNode
    let relationType, relationTypeFormatted: String

    enum CodingKeys: String, CodingKey {
        case node
        case relationType = "relation_type"
        case relationTypeFormatted = "relation_type_formatted"
    }
}

// MARK: - StartSeason
struct AnimeDetailsStartSeason: Codable {
    let year: Int
    let season: String
}

// MARK: - Statistics
struct AnimeDetailsStatistics: Codable {
    let status: Status
    let numListUsers: Int

    enum CodingKeys: String, CodingKey {
        case status
        case numListUsers = "num_list_users"
    }
}

// MARK: - Status
struct AnimeDetailsStatus: Codable {
    let watching, completed, onHold, dropped: String
    let planToWatch: String

    enum CodingKeys: String, CodingKey {
        case watching, completed
        case onHold = "on_hold"
        case dropped
        case planToWatch = "plan_to_watch"
    }
}

// MARK: - Encode/decode helpers

class AnimeDetailsJSONNull: Codable, Hashable {

    public static func == (lhs: AnimeDetailsJSONNull, rhs: AnimeDetailsJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(AnimeDetailsJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class AnimeDetailsJSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class AnimeDetailsJSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(AnimeDetailsJSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return AnimeDetailsJSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return AnimeDetailsJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: AnimeDetailsJSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<AnimeDetailsJSONCodingKey>, forKey key: AnimeDetailsJSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return AnimeDetailsJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: AnimeDetailsJSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<AnimeDetailsJSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: AnimeDetailsJSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<AnimeDetailsJSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = AnimeDetailsJSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is AnimeDetailsJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: AnimeDetailsJSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try AnimeDetailsJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: AnimeDetailsJSONCodingKey.self) {
            self.value = try AnimeDetailsJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try AnimeDetailsJSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try AnimeDetailsJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: AnimeDetailsJSONCodingKey.self)
            try AnimeDetailsJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try AnimeDetailsJSONAny.encode(to: &container, value: self.value)
        }
    }
}
