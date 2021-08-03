//
//  PokeError.swift
//  PokemonDM
//
//  Created by lijia xu on 8/3/21.
//

import Foundation

enum PokeError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case couldNotDecodeImage
    
    var errorDescription: String? {
        
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let err):
            return err.localizedDescription
        case .noData:
            return "the server responded with no data"
        case .couldNotDecodeImage:
            return "Unable to turn data into an image"
        }
        
    }//End Of errorDescription
    
}//end of enum
