//
//  PokemonController.swift
//  PokemonDM
//
//  Created by lijia xu on 8/3/21.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonComponent = "pokemon"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokeError>) -> Void) {
        
        guard let baseURL = baseURL else {
            print("base url fail")
            completion( .failure(.invalidURL) )
            return
        }
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonComponent)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm)
        
       //print(" finalURL  val: \(finalURL) line: \(#line) Function: \(#function) Time: \(Date())")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, err in
            if let err = err {
                print(" error network call  val: \(err) line: \(#line) Function: \(#function) Time: \(Date())")
                completion(.failure(.thrownError(err)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POKEMON STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
                
            } catch {
                completion(.failure(.thrownError(error)))

            }
            return
        }.resume()
        
    }//End Of fetchPokemon function
    
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping ( (Result<UIImage, PokeError>) -> Void) ) {
        guard let url = pokemon.sprites.frontDefault else {
            print("no front")
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if let error = err {
                completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POKEMON STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let sprite = UIImage(data: data) else {
                completion(.failure(.couldNotDecodeImage))
                return
            }
            
            completion(.success(sprite))
            return
            
        }.resume()
        
    }//End Of fetch Sprite function
    
    
}//End Of PokemonController
