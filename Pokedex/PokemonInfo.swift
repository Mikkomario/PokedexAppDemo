//
//  PokemonData.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

struct pokemonInfo
{
	let description: String
	let primaryType: Type
	let secondaryType: Type?
	let abilities: [Ability]
	let baseStats: [Stat : Int]
	
	init(description: String, abilities: [Ability], baseStats: [Stat : Int], type1: Type, type2: Type? = nil)
	{
		self.description = description
		self.primaryType = type1
		self.secondaryType = type2
		self.abilities = abilities
		self.baseStats = baseStats
	}
}
