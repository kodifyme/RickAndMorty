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
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

