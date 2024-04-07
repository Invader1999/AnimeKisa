//
//  TodayAnimeViewMode.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 24/03/24.
//
import Foundation
import Observation

enum TodayAnimeListError: Error {
    case InvalidURL(String)
    case InvalidResponse
    case InvalidData
}


enum TimeConversionError: Error {
    case networkingError
    case invalidResponse
}


@Observable
class TodayAnimeViewModel{
    var animeThemes:[AnimeThemesModel] = []
    var todayAnimeDataArray:[AnimeDataModel] = []
    var charactersArray:[CharacterModel] = []
    var isLoaded = false
    func getTodayAiringAnimeData() async throws {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" 
        let today = dateFormatter.string(from: Date()).lowercased()
        print(today)
        let endpoint = "https://api.jikan.moe/v4/schedules?filter=\(today)&limit=20"
        
        guard let url = URL(string: endpoint) else { throw TodayAnimeListError.InvalidURL("Invalid URL") }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        request.cachePolicy = .returnCacheDataElseLoad
        let (data, response) = try await URLSession.shared.data(for: request)
        // print("Top Airing Data",data,response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw TodayAnimeListError.InvalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AnimeDataModel.self, from: data)
            // print("Data received:", decodedData)
            todayAnimeDataArray.removeAll()
            todayAnimeDataArray.append(decodedData)
           print("TopAirAnimeData Array", todayAnimeDataArray)
        } catch {
            print(error)
            throw TodayAnimeListError.InvalidData
        }
    }
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
    }
  
//    func convertTime(fromTimeZone: String, dateTime: String, toTimeZone: String, dstAmbiguity: String) async throws -> Data {
//        let url = URL(string: "https://timeapi.io/api/Conversion/ConvertTimeZone")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        let parameters: [String: Any] = [
//            "fromTimeZone": fromTimeZone,
//            "dateTime": dateTime,
//            "toTimeZone": toTimeZone,
//            "dstAmbiguity": dstAmbiguity
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            return data
//        } catch {
//            throw TimeConversionError.networkingError
//        }
//    }

}
