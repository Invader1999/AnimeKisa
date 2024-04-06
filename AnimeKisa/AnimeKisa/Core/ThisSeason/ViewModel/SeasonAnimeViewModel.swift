//
//  SeasonAnimeViewModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 26/03/24.
// O

import Foundation
import Observation

enum SeasonalAnimeError: Error {
    case InvalidURL
    case InvalidResponse
    case InvalidData
}

@Observable
class SeasonAnimeViewModel {
    var seasonAnimeDataArray: [SeasonAndRecommendationsAnimeModel] = []
    var animeDetailsArray: [AnimeDetailsModel] = []
    var isLoading = false
    var isLoaded = false
    var season:String = ""
    var year:String = ""
        
    func getSeasonalAnimeDetails(limit: String) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
            
        let (year, season) = getYearAndSeason()
        self.year = year
        self.season = season
        let endpoint = "https://api.myanimelist.net/v2/anime/season/\(year)/\(season)?limit=\(limit)"
        print("Season AnimeEndpoint is", endpoint)
        guard let url = URL(string: endpoint) else { throw SeasonalAnimeError.InvalidURL }
            
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
            
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SeasonalAnimeError.InvalidResponse
        }
            
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SeasonAndRecommendationsAnimeModel.self, from: data)
            print("Data received:", decodedData)
            // seasonAnimeDataArray.removeAll()
            seasonAnimeDataArray.append(decodedData)
                
            // Fetch anime details for each anime
            if let dataArray = decodedData.data {
                for datum in dataArray {
                    if let node = datum.node, let animeId = node.id {
                        // Call function to fetch anime details
                        try await fetchAnimeDetails(id: animeId)
                    }
                }
            }
                
        } catch {
            print(error)
            throw SeasonalAnimeError.InvalidData
        }
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

    func fetchAnimeDetails(id: Int) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
           
        let endpoint = "https://api.myanimelist.net/v2/anime/\(id)?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics"
           
        guard let url = URL(string: endpoint) else { throw SeasonalAnimeError.InvalidURL }
           
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
           
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SeasonalAnimeError.InvalidResponse
        }
           
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AnimeDetailsModel.self, from: data)
            print("Anime Details Data received:", decodedData)
            // animeDetailsArray.removeAll()
            animeDetailsArray.append(decodedData)
               
        } catch {
            print(error)
            throw SeasonalAnimeError.InvalidData
        }
    }
}
