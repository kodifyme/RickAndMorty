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
    static let personagesPath = "/api/character"
    static let episodePath = "/api/episode"
}

class NetworkService {
    
    struct QueryItem {
        static let page = "page"
        static let name = "name"
        static let status = "status"
        static let gender = "gender"
    }
    
    static let shared = NetworkService()
    private let session = URLSession.shared
    
    private init() {}
    
    func generateURLComponents(using path: String) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = path
        return components.url
    }
    
    func fetchPersonages(page: Int, searchQuery: String?, filterCriteria: Filter?, completion: @escaping (Result<[Personage], Error>) -> Void) {
        
        guard let basePersonageURL = generateURLComponents(using: Constants.personagesPath) else { return }
        
        guard var components = URLComponents(url: basePersonageURL, resolvingAgainstBaseURL: false) else { return }
        
        components.queryItems = [
            URLQueryItem(name: QueryItem.page, value: "\(page)")
        ]
        
        if let searchQuery, !searchQuery.isEmpty {
            components.queryItems?.append(URLQueryItem(name: QueryItem.name, value: searchQuery))
        }
        
        if let filterCriteria {
            if let status = filterCriteria.status {
                components.queryItems?.append(URLQueryItem(name: QueryItem.status, value: status))
            }
            if let gender = filterCriteria.gender {
                components.queryItems?.append(URLQueryItem(name: QueryItem.gender, value: gender))
            }
        }
        
        guard let url = components.url else { return }
        
        session.dataTask(with: url, completionHandler: { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let results = try JSONDecoder().decode(PersonagesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.personages ?? []))
                }
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url, completionHandler: { data, _, error in
            guard let data, error == nil else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }).resume()
    }
    
    func fetchEpisodesNames(from episodesURLs: [String], completion: @escaping (Result<[Episode], Error>) -> Void) {
        
        let episodesIDs = episodesURLs.compactMap { URL(string: $0)?.lastPathComponent }
        guard !episodesIDs.isEmpty else {
            completion(.success([]))
            return
        }
        
        let episodesIDsString = episodesIDs.joined(separator: ",")
        
        guard let url = generateURLComponents(using: Constants.episodePath + "/" + episodesIDsString) else { return }
        
        session.dataTask(with: url, completionHandler: { data, _, error in
            
            guard let data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                var episodes = [Episode]()
                
                if episodesIDs.count == 1 {
                    episodes.append(try JSONDecoder().decode(Episode.self, from: data))
                } else {
                    episodes = try JSONDecoder().decode([Episode].self, from: data)
                }
                
                DispatchQueue.main.async {
                    completion(.success(episodes))
                }
                
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}
