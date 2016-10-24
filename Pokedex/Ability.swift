//
//  Ability.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

struct Ability
{
	// All initialised ability values by name
	static var values = [String : Ability]()
	
	let name: String
	let description: String
	
	init(name: String, description: String)
	{
		self.name = name
		self.description = description
		
		Ability.values[name] = self
	}
}
