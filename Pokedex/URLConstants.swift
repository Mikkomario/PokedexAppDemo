//
//  URLConstants.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

private let URL_BASE = "http://pokeapi.co/api/v2/"

func URL_POKEMON(id: Int) -> String {return "\(URL_BASE)/pokemon/\(id)"}
