// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AnimeDataModel: Codable{
    var id:String? = UUID().uuidString
    let pagination: Pagination?
    let data: [TodayAnimeDatum]?
}

// MARK: - Datum
struct TodayAnimeDatum: Codable {
    let id:String? = UUID().uuidString
    let malID: Int?
    let url: String?
    let images: [String: TodayAnimeImage]?
    let trailer: TodayAnimeTrailer?
    let approved: Bool?
    let titles: [Title]?
    let title: String?
    let titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type: TodayAnimeDatumType?
    let source: String?
    let episodes: Int?
    let status: Status?
    let airing: Bool?
    let aired: TodayAnimeAired?
    let duration: String?
    let rating: TodayAnimeRating?
    let score: Double?
    let scoredBy: Int?
    let rank, popularity, members, favorites: Int?
    let synopsis, background: String?
    let season: TodayAnimeSeason?
    let year: Int?
    let broadcast: TodayAnimeBroadcast?
    let producers, licensors, studios, genres: [TodayAnimeDemographic]?
    let explicitGenres: [TodayAnimeJSONAny]?
    let themes, demographics: [TodayAnimeDemographic]?
    var convertedBroadcastTime: String? {
            guard let broadcast = self.broadcast,
                  let time = broadcast.time,
                  let timezone = broadcast.timezone else {
                print("Missing broadcast data")
                return nil
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone(identifier: timezone.rawValue)

            guard let broadcastTime = dateFormatter.date(from: time) else {
                print("Failed to parse broadcast time:", time)
                return nil
            }

            dateFormatter.timeZone = TimeZone.current // Convert to current time zone
            let convertedTime = dateFormatter.string(from: broadcastTime)

            let dateFormatters = DateFormatter()
            dateFormatters.dateFormat = "HH:mm"

            guard let date1 = dateFormatters.date(from: convertedTime) else {
                print("Failed to convert convertedTime to date")
                return nil
            }

            let date2 = Date()

            var components1 = Calendar.current.dateComponents([.hour, .minute], from: date1)
            let components2 = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: date2)

            components1.year = components2.year
            components1.month = components2.month
            components1.day = components2.day

            guard let date3 = Calendar.current.date(from: components1) else {
                print("Failed to create date from components1")
                return nil
            }

            let timeIntervalInMinutes = date3.timeIntervalSince(date2) / 60

            // Convert time interval to hours and minutes
            let hours = Int(timeIntervalInMinutes / 60)
            let minutes = Int(timeIntervalInMinutes.truncatingRemainder(dividingBy: 60))
        if timeIntervalInMinutes < 0{
            return ("Aired \(Int(-hours)) hr \(Int(-minutes)) min ago")
        }
        else{
            return ("Airing in \(hours) hr \(minutes) min")
        }
          
        }

    var BrodcastTime: String? {
        guard let broadcast = self.broadcast,
              let time = broadcast.time,
              let timezone = broadcast.timezone else {
            print("Missing broadcast data")
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: timezone.rawValue)
        
        guard let broadcastTime = dateFormatter.date(from: time) else {
            print("Failed to parse broadcast time:", time)
            return nil
        }
        
        dateFormatter.timeZone = TimeZone.current // Convert to current time zone
        let convertedTime = dateFormatter.string(from: broadcastTime)
        
        return convertedTime
        
    }
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
}


// MARK: - Aired
struct TodayAnimeAired: Codable {
    let from: String?
    let to: String?
    let prop: TodayAnimeProp?
    let string: String?
    
}
// MARK: - Prop
struct TodayAnimeProp: Codable {
    let from, to: From?
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Broadcast
struct TodayAnimeBroadcast: Codable {
    let day: String?
    let time: String?
    let timezone: TodayAnimeTimezone?
    let string: String?
}
//
//enum Day: String, Codable {
//    case sundays = "Sundays"
//}

enum TodayAnimeTimezone: String, Codable {
    case asiaTokyo = "Asia/Tokyo"
}

// MARK: - Demographic
struct TodayAnimeDemographic: Codable {
    let malID: Int?
    let type: TodayAnimeDemographicType?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

enum TodayAnimeDemographicType: String, Codable {
    case anime = "anime"
}

// MARK: - Image
struct TodayAnimeImage: Codable {
    let imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

enum TodayAnimeRating: String, Codable {
    case gAllAges = "G - All Ages"
    case pg13Teens13OrOlder = "PG-13 - Teens 13 or older"
    case r17ViolenceProfanity = "R - 17+ (violence & profanity)"
    case pgChilderen = "PG - Children"
    case mildNudity = "R+ - Mild Nudity"
    case unknown = "Unknown"
}

enum TodayAnimeSeason: String, Codable {
    case fall = "fall"
    case spring = "spring"
    case winter = "winter"
}

enum Status: String, Codable {
    case currentlyAiring = "Currently Airing"
}

// MARK: - Title
struct Title: Codable {
    let type: TodayAnimeTitleType?
    let title: String?
}

enum TodayAnimeTitleType: String, Codable {
    case english = "English"
    case japanese = "Japanese"
    case spanish = "Spanish"
    case synonym = "Synonym"
    case german = "German"
    case french = "French"
    case typeDefault = "Default"
    case unowned = "unkown"
}

// MARK: - Trailer
struct TodayAnimeTrailer: Codable {
    let youtubeID: String?
    let url, embedURL: String?
    let images: TodayAnimeImages?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}

// MARK: - Images
struct TodayAnimeImages: Codable {
    let imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    let maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

enum TodayAnimeDatumType: String, Codable {
    case tv = "TV"
}

// MARK: - Pagination
struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool?
    let currentPage: Int?
    let items: TodayAnimeItems?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

// MARK: - Items
struct TodayAnimeItems: Codable {
    let count, total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
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

class TodayAnimeJSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(TodayAnimeJSONAny.self, context)
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
            return JSONNull()
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
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
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
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
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

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
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
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
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
            self.value = try TodayAnimeJSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try TodayAnimeJSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try TodayAnimeJSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try TodayAnimeJSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try TodayAnimeJSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try TodayAnimeJSONAny.encode(to: &container, value: self.value)
        }
    }
}
