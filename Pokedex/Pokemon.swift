//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 5.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

// Exercise used class. Change when necessary.
struct Pokemon
{
	let name: String
	let id: Int
	let description: String
	let primaryType: Type
	let secondaryType: Type?
	let abilities: [Ability]
	let baseStats: [Stat : Int]
	
	init(id: Int, name: String, description: String, abilities: [Ability], baseStats: [Stat : Int], type1: Type, type2: Type? = nil)
	{
		self.id = id
		self.name = name
		self.description = description
		self.primaryType = type1
		self.secondaryType = type2
		self.abilities = abilities
		self.baseStats = baseStats
	}
}
