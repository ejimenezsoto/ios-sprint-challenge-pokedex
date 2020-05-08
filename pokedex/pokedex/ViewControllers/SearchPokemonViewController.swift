//
//  SearchPokemonViewController.swift
//  pokedex
//
//  Created by Enzo Jimenez-Soto on 5/8/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class SearchPokemonDetailViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    

    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    

    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    var image: UIImage?
//    var pokemonImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        updateViews()
        updateImageViews()
    }

    
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        guard let image = image else { return }
        guard let pokemonController = pokemonController else { return }
        pokemonController.pokemonList.append(pokemon)
        pokemonController.pokemonImages.append(image)
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if pokemon != nil {
            searchBar.isHidden = true
        } else {
            searchBar.isHidden = false
        }
        guard let pokemon = pokemon else { return }
        pokemonName.text = pokemon.name
        idLabel.text = pokemon.id.description
        var typesList = ""
        var abilitiesList = ""
        
        for index in pokemon.types {
            if typesList.isEmpty {
                typesList = index.type.name
            } else if !typesList.isEmpty {
                typesList = typesList + ", " + index.type.name
            }
        }
        
        for index in pokemon.abilities {
            if abilitiesList.isEmpty {
                abilitiesList = index.ability.name
            } else if !abilitiesList.isEmpty {
                abilitiesList = abilitiesList + ", " + index.ability.name
            }
        }
        
        
        
        typesLabel.text = typesList
        abilitiesLabel.text = abilitiesList
//        self.pokemon = pokemon
    }
    
    func updateImageViews() {
        guard let image = self.image else { return }
        pokemonImage.image = image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchPokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchingFor = searchBar.text else { return }
        guard let pokemonController = self.pokemonController else { return }
        pokemonController.searchPokemon(with: searchingFor) { (result) in
            if let pokemonResult = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemonResult
                    self.updateViews()
                }
                
                pokemonController.fetchImage(at: pokemonResult.sprites.frontDefault) { (result) in
                    if let imageResult = try? result.get() {
                        DispatchQueue.main.async {
                            self.image = imageResult
                            self.updateImageViews()
                        }
                    }
                }
            }
        }
    }
}

