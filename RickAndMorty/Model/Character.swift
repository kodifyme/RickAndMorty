//
//  Character.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

struct CharacterResponse: Codable {
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let image: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).lowercased()
        switch rawValue {
        case "alive":
            self = .alive
        case "dead":
            self = .dead
        case "unknown":
            self = .unknown
        default:
            self = .unknown
        }
    }
}

