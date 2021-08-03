//
//  PokeViewController.swift
//  PokemonDM
//
//  Created by lijia xu on 8/3/21.
//

import UIKit

class PokeViewController: UIViewController {
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    func fetchSpriteAndUpdateViews(for pokemon: Pokemon){
        PokemonController.fetchSprite(for: pokemon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self?.pokeImageView.image = sprite
                    self?.pokeNameLabel.text = pokemon.name
                    self?.pokeIDLabel.text = "\(pokemon.id)"
                    
                case .failure(let err):
                    self?.presentErrorToUser(localizedError: err)
                }
            }
            
        }//End Of fetchSpriteAndUpdateViews
        
    }//End Of func
    
    @IBAction func shinyButtonTapped(_ sender: Any) {
        
    }
    
    
}//End Of class

extension PokeViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        PokemonController.fetchPokemon(searchTerm: searchTerm) { [weak self] result in
            switch result {
            case .success( let pokemon ):
                self?.fetchSpriteAndUpdateViews(for: pokemon)
            case .failure( let err ) :
                self?.presentErrorToUser(localizedError: err)
            }
            
        }
    }
    
}//End Of extension
