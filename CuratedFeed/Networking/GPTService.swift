//
//  GPTService.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation

protocol GPTServiceProtocol: AnyObject {
    func executeRequest(prompt: String, maxTokens: Int) async -> GPTResponse?
}

class GPTService {
    
    struct Constants {
        static let authorizationHeaderField: String = "Authorization"
        static let contentTypeHeaderField: String = "Content-Type"
        static let contentValue: String = "application/json"
        static let postMethodType: String = "POST"
        static let gptModel: String = "gpt-3.5-turbo"
        static let temperature: Double = 0.7
        static let urlString: String = "https://api.openai.com/v1/completions"
        static let apiKey: String = "API_KEY"
    }
    
    private var apiKey: String? {
        ProcessInfo.processInfo.environment[Constants.apiKey]
    }
    
    private var urlString: String {
        Constants.urlString
    }
}

extension GPTService: GPTServiceProtocol {
    
    func executeRequest(prompt: String, maxTokens: Int) async -> GPTResponse? {
        guard
            let apiKey = apiKey,
            let url = URL(string: urlString)
        else { return nil }
        
        var request = URLRequest(url: url)
        encodeURLRequest(
            request: &request,
            prompt: prompt,
            maxTokens: maxTokens,
            apiKey: apiKey
        )
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(GPTResponse.self, from: data)
            print("Response \(response.choice)")
            return response
        }
        catch {
            print("Trouble executing and decoding results for GPT Request")
            return nil
        }
    }
    
    func encodeURLRequest(request: inout URLRequest, prompt: String, maxTokens: Int, apiKey: String) {
        request.addValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: Constants.authorizationHeaderField
        )
        request.addValue(
            Constants.contentValue,
            forHTTPHeaderField: Constants.contentTypeHeaderField
        )
        request.httpMethod = Constants.postMethodType
        
        let requestBody = GPTRequest(
            model: Constants.gptModel,
            prompt: prompt,
            temperature: Constants.temperature,
            maxTokens: maxTokens
        )
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        }
        catch {
            print("Trouble encoding request body to URL Request")
        }
    }
}
