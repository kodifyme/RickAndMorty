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
    static let episodePath = "api/episode"
}

class NetworkService {
    
    static let shared = NetworkService()
    private let session = URLSession.shared
    
    private init() {}
    
    private lazy var baseURL: URL? = {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = "/\(Constants.characterPath)"
        return components.url
    }()
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let baseURL else { return }
        
        let task = session.dataTask(with: baseURL) { data, _, error in
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
}
