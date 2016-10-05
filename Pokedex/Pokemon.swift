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
	
	init(id: Int, name: String)
	{
		self.id = id
		self.name = name
	}
}
