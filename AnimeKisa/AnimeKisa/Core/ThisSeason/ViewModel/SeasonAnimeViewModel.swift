//
//  SeasonAnimeViewModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
//O

import Foundation
import Observation


enum SeasonalAnimeError: Error {
    case InvalidURL
    case InvalidResponse
    case InvalidData
}

@Observable
class SeasonAnimeViewModel{
    var seasonAnimeDataArray:[SeasonAndRecommendationsAnimeModel] = []
    var isLoading = false
    
    func getSeasonalAnimeDetails(limit:String) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
        
        let (year, season) = getYearAndSeason()
        
        //let endpoint = "https://api.myanimelist.net/v2/anime/season/\(year)/\(season)?limit=20"
        let endpoint = "https://api.myanimelist.net/v2/anime/season/2024/summer?limit=\(limit)"
        print("Season AnimeEndpoint is",endpoint)
        guard let url = URL(string: endpoint) else { throw SeasonalAnimeError.InvalidURL }
//    https://api.myanimelist.net/v2/anime/season/2024/spring?limit=20
//    https://api.myanimelist.net/v2/anime/spring/2024/spring?
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .useProtocolCachePolicy
        
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Anime Detail Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SeasonalAnimeError.InvalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SeasonAndRecommendationsAnimeModel.self, from: data)
            seasonAnimeDataArray.removeAll()
            print("Data received:", decodedData)
            seasonAnimeDataArray.append(decodedData)
            
        } catch {
            print(error)
            throw SeasonalAnimeError.InvalidData
        }
        // print(animeDetailDataArray)
    }
    
    
    
    func getYearAndSeason() -> (year: String, season: String) {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())
        var season = ""
        
        switch month {
        case 12, 1, 2: season = "winter"
        case 3, 4, 5: season = "spring"
        case 6, 7, 8: season = "summer"
        case 9, 10, 11: season = "fall"
        default: season = "unknown"
        }
        
        return (year: String(year), season: season)
    }
    
    
    
    
}


