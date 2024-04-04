//
//  AnimeDetailsViewModel.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//

import Foundation
import Observation


@Observable
class AnimeDetailsViewModel{
    var animeDetails:AnimeDetailsModel?
    func getRecommendationAnimeDetails(id:Int) async throws {
        var headers = [String: String]()
        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
        headers["Content-Type"] = "application/json"
         
        let endpoint = "https://api.myanimelist.net/v2/anime/\(id)?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics"
        
        guard let url = URL(string: endpoint) else { throw RecommendationAnimeError.InvalidURL }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        animeDetails = nil
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Anime Detail Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecommendationAnimeError.InvalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AnimeDetailsModel.self, from: data)
            print("Anime Details Data received:", decodedData)
            animeDetails = decodedData
            
        } catch {
            print(error)
            throw RecommendationAnimeError.InvalidData
        }
        // print(animeDetailDataArray)
    }
}
