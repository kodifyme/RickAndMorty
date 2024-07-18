//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

struct Constants {
    static let scheme = "https"
    static let host = "rickandmortyapi.com"
    static let characterPath = "api/character"
    static let episodePath = "/api/episode/"
}

class NetworkService {
    
    struct QueryItem {
        static let page = "page"
    }
    
    static let shared = NetworkService()
    private let session = URLSession.shared
    
    private lazy var baseCharacterURL: URL? = {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = "/\(Constants.characterPath)"
        return components.url
    }()
    
    private init() {}
    
    func fetchCharacters(page: Int, completion: @escaping (Result<[Character], Error>) -> Void) {
        
        guard var baseCharacterURL else { return }
        
        guard var components = URLComponents(url: baseCharacterURL, resolvingAgainstBaseURL: false) else { return }
        
        components.queryItems = [
            URLQueryItem(name: QueryItem.page, value: "\(page)")
        ]
        
        guard let url = components.url else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.characters))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(error!))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
    }
    
    func fetchEpisodeNames(from episodeURLs: [String], completion: @escaping (Result<[String], Error>) -> Void) {
        let episodeIDs = episodeURLs.compactMap { URL(string: $0)?.lastPathComponent }
        guard !episodeIDs.isEmpty else {
            completion(.success([]))
            return
        }
        
        let episodeIDString = episodeIDs.joined(separator: ",")
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.episodePath + episodeIDString
        
        guard let url = components.url else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                if episodeIDs.count == 1 {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success([episode.name]))
                    }
                } else {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    let episodeNames = episodes.map { $0.name }
                    DispatchQueue.main.async {
                        completion(.success(episodeNames))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
