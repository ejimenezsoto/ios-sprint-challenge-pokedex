//
//  PokedexTableViewController.swift
//  pokedex
//
//  Created by Enzo Jimenez-Soto on 5/8/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemonController.pokemonList[indexPath.row].name

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            guard let detailVC = segue.destination as? SearchPokemonDetailViewController else { return }
            detailVC.pokemonController = self.pokemonController
        } else if segue.identifier == "ViewPokemonSegue" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            guard let detailVC = segue.destination as? SearchPokemonDetailViewController else { return }
            detailVC.pokemon = self.pokemonController.pokemonList[indexPath.row]
            detailVC.image = self.pokemonController.pokemonImages[indexPath.row]
        }
    }
    

}
