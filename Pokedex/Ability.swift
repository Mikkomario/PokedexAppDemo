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
	let name: String
	let description: String
	let hidden: Bool
	
	init(name: String, description: String, isHidden: Bool = false)
	{
		self.name = name
		self.description = description
		self.hidden = isHidden
	}
}
