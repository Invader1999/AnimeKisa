//
//  RecommendationViewModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 29/03/24.
//

import Foundation
import Observation

enum RecommendationAnimeError: Error {
    case InvalidURL
    case InvalidResponse
    case InvalidData
}

@Observable
class RecommendationViewModel {
    var recommendationDataArray: [SeasonAndRecommendationsAnimeModel] = []
    var animeDetailsArray: [AnimeDetailsModel] = []
    var isLoaded = false
    
    func getRecommendationAnimeDetails(limit: String, accessToken: String) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(accessToken)"
           
        let endpoint = "https://api.myanimelist.net/v2/anime/suggestions?limit=\(limit)"
        print("Season AnimeEndpoint is", endpoint)
        guard let url = URL(string: endpoint) else { throw RecommendationAnimeError.InvalidURL }
           
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
           
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecommendationAnimeError.InvalidResponse
        }
           
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SeasonAndRecommendationsAnimeModel.self, from: data)
            print("Data received:", decodedData)
            recommendationDataArray.append(decodedData)
               
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
            throw RecommendationAnimeError.InvalidData
        }
    }
       
    func fetchAnimeDetails(id: Int) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
        // headers["Authorization"] = "Bearer \(accessToken)"
           
        let endpoint = "https://api.myanimelist.net/v2/anime/\(id)?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics"
           
        guard let url = URL(string: endpoint) else { throw RecommendationAnimeError.InvalidURL }
           
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
           
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecommendationAnimeError.InvalidResponse
        }
           
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AnimeDetailsModel.self, from: data)
            print("Anime Details Data received:", decodedData)
            // animeDetailsArray.removeAll()
            animeDetailsArray.append(decodedData)
               
        } catch {
            print(error)
            throw RecommendationAnimeError.InvalidData
        }
    }
}
