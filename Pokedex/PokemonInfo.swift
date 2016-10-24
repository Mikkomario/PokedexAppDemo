//
//  PokemonData.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

struct PokemonInfo
{
	let descriptions: [String]
	let primaryType: Type
	let secondaryType: Type?
	let abilities: [(Ability, Bool)] // Ability, is hidden
	let baseStats: [Stat : Int]
	
	init(descriptions: [String], abilities: [(Ability, Bool)], baseStats: [Stat : Int], type1: Type, type2: Type? = nil)
	{
		self.descriptions = descriptions
		self.primaryType = type1
		self.secondaryType = type2
		self.abilities = abilities
		self.baseStats = baseStats
	}
}
