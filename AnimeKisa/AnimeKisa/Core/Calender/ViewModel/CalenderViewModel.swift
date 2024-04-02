//
//  CalenderViewModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 25/03/24.
//

import Foundation
import Observation
enum CalenderAnimeListError: Error {
    case InvalidURL(String)
    case InvalidResponse
    case InvalidData
}

@Observable
class CalenderViewModel{
    var animeAiringDataArray:[AnimeDataModel] = []
    var selectedDay:String = ""
    var isLoading = false
    init(){
        getCurrentDayString()
        getCurrentDayIndex()
    }
  
    func getCurrentDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" will give the full name of the day (e.g., Monday)
        selectedDay = dateFormatter.string(from: Date())
        return dateFormatter.string(from: Date())
    }
    
    func getCurrentDayIndex() -> Int? {
        let currentDayString = getCurrentDayString().lowercased()
        let dayIndex: Int?

        switch currentDayString {
        case "monday":
            dayIndex = 0
        case "tuesday":
            dayIndex = 1
        case "wednesday":
            dayIndex = 2
        case "thursday":
            dayIndex = 3
        case "friday":
            dayIndex = 4
        case "saturday":
            dayIndex = 5
        case "sunday":
            dayIndex = 6
        default:
            dayIndex = nil
        }

        return dayIndex
    }
        
        
    func getAiringAnimeData(day:String) async throws {
            var headers = [String: String]()
            headers["Content-Type"] = "application/json"
        
            let endpoint = "https://api.jikan.moe/v4/schedules?filter=\(day)&limit=20"
          
            guard let url = URL(string: endpoint) else { throw CalenderAnimeListError.InvalidURL("Invalid URL") }

            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = "GET"
            request.cachePolicy = .useProtocolCachePolicy
            animeAiringDataArray.removeAll()
            isLoading = true
            
            let (data, response) = try await URLSession.shared.data(for: request)
            // print("Top Airing Data",data,response)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw CalenderAnimeListError.InvalidResponse
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(AnimeDataModel.self, from: data)
                // print("Data received:", decodedData)
                animeAiringDataArray.append(decodedData)
                isLoading = false
               //print("TopAirAnimeData Array", animeAiringDataArray)
                print("Count of animeData is :",animeAiringDataArray.map({ data in
                    data.data?.count
                }))
            } catch {
                print(error)
                throw CalenderAnimeListError.InvalidData
            }
        }
        
}
