//
//  PokemonController.swift
//  pokedex
//
//  Created by Enzo Jimenez-Soto on 5/8/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//
import UIKit


enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: Pokemon?
    var pokemonImage: UIImage?
    var pokemonList: [Pokemon] = []
    var pokemonImages: [UIImage] = []
    
    
    func searchPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent("pokemon/\(name.lowercased())")
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let newPokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = newPokemon
                completion(.success(newPokemon))
            } catch {
                completion(.failure(.noDecode))
                return
            }
        } .resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
    
}
