//
//  Pokemon.swift
//  pokedex
//
//  Created by Enzo Jimenez-Soto on 5/8/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [AbilityElement]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

struct AbilityElement: Codable {
    let ability: TypeClass
    let isHidden: Bool
    let slot: Int
    
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct TypeClass: Codable {
    let name: String
    let url: String
    
}

struct Sprites: Codable {
    let frontDefault: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
}

struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}
