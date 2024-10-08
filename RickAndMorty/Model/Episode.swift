//
//  Episode.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
