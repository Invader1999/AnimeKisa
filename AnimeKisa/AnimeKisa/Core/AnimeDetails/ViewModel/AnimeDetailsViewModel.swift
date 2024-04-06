//
//  AnimeDetailsViewModel.swift
//  AnimeKisa
//
//  Created by Hemanth Reddy Kareddy on 01/04/24.
//

import Foundation
import Observation

enum AnimeDetailsError: Error {
    case InvalidURL
    case InvalidResponse
    case InvalidData
}


@Observable
class AnimeDetailsViewModel{
    //var animeDetails:AnimeDetailsModel?
    var animeThemes:[AnimeThemesModel] = []
    var charactersArray:[CharacterModel] = []
    
    func getAnimeThemesDetails(id:Int) async throws {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
         
        let endpoint = "https://api.jikan.moe/v4/anime/\(id)/themes"
        
        guard let url = URL(string: endpoint) else { throw AnimeDetailsError.InvalidURL }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        animeThemes.removeAll()
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Anime Detail Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AnimeDetailsError.InvalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AnimeThemesModel.self, from: data)
            print("Anime Themes Data received:", decodedData)
            animeThemes.append(decodedData)
            
        } catch {
            print(error)
            throw AnimeDetailsError.InvalidData
        }
        // print(animeDetailDataArray)
    }
    
    
    func getAnimeCharacters(id:Int) async throws {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
         
        let endpoint = "https://api.jikan.moe/v4/anime/\(id)/characters"
        
        guard let url = URL(string: endpoint) else { throw AnimeDetailsError.InvalidURL }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        charactersArray.removeAll()
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Anime Detail Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AnimeDetailsError.InvalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(CharacterModel.self, from: data)
            print("Charcaters Data received:", decodedData)
            charactersArray.append(decodedData)
            
        } catch {
            print(error)
            throw AnimeDetailsError.InvalidData
        }
        // print(animeDetailDataArray)
    }
    
//    func getAnimeDetails(id:Int) async throws {
//        var headers = [String: String]()
//        headers["X-MAL-CLIENT-ID"] = "e66dfc376c43baef1a33afd05b5ccce9"
//        headers["Content-Type"] = "application/json"
//        animeDetails = nil
//        let endpoint = "https://api.myanimelist.net/v2/anime/\(id)?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics"
//        
//        guard let url = URL(string: endpoint) else { throw RecommendationAnimeError.InvalidURL }
//        
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = headers
//        request.httpMethod = "GET"
//        request.cachePolicy = .returnCacheDataElseLoad
//       
//        let (data, response) = try await URLSession.shared.data(for: request)
//        // print("Anime Detail Data",data,response)
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw RecommendationAnimeError.InvalidResponse
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(AnimeDetailsModel.self, from: data)
//            print("Anime Details Data received:", decodedData)
//            animeDetails = decodedData
//            
//        } catch {
//            print(error)
//            throw RecommendationAnimeError.InvalidData
//        }
//        // print(animeDetailDataArray)
//    }
}
