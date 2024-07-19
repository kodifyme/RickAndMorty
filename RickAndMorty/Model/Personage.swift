//
//  Personage.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

struct PersonagesResponse: Codable {
    let personages: [Personage]?
    
    enum CodingKeys: String, CodingKey {
        case personages = "results"
    }
}

struct Personage: Codable {
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
    
    var coloring: UIColor {
        switch self {
        case .alive:
            return .systemGreen
        case .dead:
            return .systemRed
        case .unknown:
            return .systemGray
        }
    }
}

