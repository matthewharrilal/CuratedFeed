//
//  GPTRequest.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation

struct GPTRequest: Encodable {
    let model: String
    let prompt: String
    let temperature: Double
    let maxTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case maxTokens = "max_tokens"
    }
}
