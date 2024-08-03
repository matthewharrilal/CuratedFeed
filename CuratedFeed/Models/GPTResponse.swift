//
//  GPTResponse.swift
//  CuratedFeed
//
//  Created by Space Wizard on 8/3/24.
//

import Foundation

struct GPTResponse: Decodable {
    let choice: [Choice]
}

struct Choice: Decodable {
    let text: String
}
