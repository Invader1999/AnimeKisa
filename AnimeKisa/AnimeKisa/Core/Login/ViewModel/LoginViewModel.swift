//
//  LoginViewModel.swift
//  AnimeKisa
//
//  Created by Kareddy Hemanth Reddy on 28/03/24.
//

import CryptoKit
import Foundation
import KeychainSwift
import Observation
import SwiftUI

@Observable
class LoginViewModel {
    var codeVerifier: String?
    var state: String?
    var token: TokenModel?

    func AuthenticationServicesLogin() {
        let codeVerifier = generateCodeVerifier()
        print("Code Verifier is :", codeVerifier)
       
        self.codeVerifier = codeVerifier
        
        let codeChallenge = generateCodeChallenge(from: codeVerifier)
        
        let authorizationURL = createAuthorizationURL(codeChallenge: codeChallenge)
        openAuthorizationURL(url: authorizationURL)
    }
    
    private func generateCodeVerifier() -> String {
        let verifierData = Data((0 ..< 32).map { _ in UInt8.random(in: 0 ... 255) })
        let finalData = verifierData.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
        // self.codeVerifier = finalData
        print(finalData, "Code Verifier is")
        return finalData
    }
    
    func generateCodeChallenge(from codeVerifier: String) -> String {
        guard let verifierData = codeVerifier.data(using: .utf8) else { return "" }
        let hash = SHA256.hash(data: verifierData)
        let finalData = Data(hash).base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)

        return finalData
    }
    
    func getState() -> String {
        let state = UUID().uuidString
        self.state = state
        return state
    }

    private func createAuthorizationURL(codeChallenge: String) -> URL {
        let baseURL = "https://myanimelist.net/v1/oauth2/authorize"
        let redirectUri = "com.hemanth://something/"
        
        let queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: "e66dfc376c43baef1a33afd05b5ccce9"),
            URLQueryItem(name: "code_challenge", value: codeVerifier),
            URLQueryItem(name: "state", value: getState()),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "code_challenge_method", value: "plain"),
        ]
        
        var components = URLComponents(string: baseURL)!
        components.queryItems = queryItems
        print("Authorisation get url", components.url ?? "No Authorisation")
        return components.url!
    }
    
    private func openAuthorizationURL(url: URL) {
        UIApplication.shared.open(url)
    }

    func handleRedirectURL(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems
        else {
            print("Invalid redirect URL")
            return
        }
//        print("Components", components, "Query Items", queryItems)
        if let code = queryItems.first(where: { $0.name == "code" })?.value {
            exchangeAuthorizationCodeForTokens(authorizationCode: code)
            print("Authorization Code:", code)
        }
    }
    
    func urlEncodedFormData(from items: [URLQueryItem]) -> Data? {
        let parameterArray = items.map { item -> String in
            if item.name == "code_verifier" {
                return "\(item.name)=\(item.value ?? "")"
            } else {
                guard let encodedName = item.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let encodedValue = item.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else {
                    return ""
                }
                return "\(encodedName)=\(encodedValue)"
            }
        }
        let queryString = parameterArray.joined(separator: "&")
        return queryString.data(using: .utf8)
    }
    
    func exchangeAuthorizationCodeForTokens(authorizationCode: String) {
        let clientId = "e66dfc376c43baef1a33afd05b5ccce9"
        let redirectUri = "com.hemanth://something/"
        guard let codeVerifier = codeVerifier else {
            print("Error: Missing code verifier")
            return
        }
        print("Code Verifier is", codeVerifier)

        let queryItems = [
            URLQueryItem(name: "code", value: authorizationCode),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "code_verifier", value: self.codeVerifier),
        ]
        
        guard let httpBodyData = urlEncodedFormData(from: queryItems) else {
            print("Error: Failed to create HTTP body data")
            return
        }
        
        var urlComponents = URLComponents(string: "https://myanimelist.net/v1/oauth2/token")
        urlComponents?.queryItems = queryItems
        //print("URL To get token:\(urlComponents?.url)")
        guard let url = urlComponents?.url else {
            print("Error: Could not create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpBody = httpBodyData
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network errors
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            // Handle HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: No HTTP response")
                return
            }

            // Handle HTTP status codes
            let statusCode = httpResponse.statusCode
            guard (200 ... 299).contains(statusCode) else {
                print("HTTP Error: \(statusCode)")
                if let data = data {
                    print("Response Data:", String(data: data, encoding: .utf8) ?? "")
                }
                return
            }

            // Handle successful response
            guard let data = data else {
                print("Error: No data received")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let jsonDictionary = json else {
                    print("Error: Failed to parse JSON")
                    return
                }
                print("Received JSON:", jsonDictionary)

                let decoder = JSONDecoder()
                let tokenModel = try decoder.decode(TokenModel.self, from: data)
                self.token = tokenModel
            } catch {
                print("Error parsing JSON:", error)
            }
//            print(self.token ,"Self token is ")
        }
        
        task.resume()
    }
}

//
// private extension Data {
//    func base64URLEncodedString() -> String {
//        base64EncodedString()
//            .replacingOccurrences(of: "+", with: "-")
//            .replacingOccurrences(of: "/", with: "_")
//            .replacingOccurrences(of: "=", with: "")
//            .trimmingCharacters(in: .whitespaces)
//    }
// }
