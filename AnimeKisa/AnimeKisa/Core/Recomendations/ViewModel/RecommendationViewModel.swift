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
class RecommendationViewModel{
    var recommendationDataArray:[SeasonAndRecommendationsAnimeModel] = []
    var isLoaded = false
    func getRecommendationAnimeDetails(limit:String,accessToken:String) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(accessToken)"
         
        //let endpoint = "https://api.myanimelist.net/v2/anime/season/\(year)/\(season)?limit=20"
        let endpoint = "https://api.myanimelist.net/v2/anime/suggestions?limit=\(limit)"
        print("Season AnimeEndpoint is",endpoint)
        guard let url = URL(string: endpoint) else { throw RecommendationAnimeError.InvalidURL }
//    https://api.myanimelist.net/v2/anime/season/2024/spring?limit=20
//    https://api.myanimelist.net/v2/anime/spring/2024/spring?
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        
        recommendationDataArray.removeAll()
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Anime Detail Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecommendationAnimeError.InvalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SeasonAndRecommendationsAnimeModel.self, from: data)
            print("Data received:", decodedData)
            recommendationDataArray.append(decodedData)
            
        } catch {
            print(error)
            throw RecommendationAnimeError.InvalidData
        }
        // print(animeDetailDataArray)
    }
    
}
