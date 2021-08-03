//
//  Pokemon.swift
//  PokemonDM
//
//  Created by lijia xu on 8/3/21.
//

import Foundation

struct Pokemon: Decodable {
    
    let id: Int
    let name: String
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let frontDefault: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
        }
    }//End Of Sprites
    
}//End Of Pokemon
