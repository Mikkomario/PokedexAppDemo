//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 5.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Pokemon
{
	private var _image: UIImage?
	
	let name: String
	let id: Int
	
	var info: pokemonInfo?
	
	var url: String {return URL_POKEMON(id: self.id)}
	var image: UIImage
	{
		if _image == nil
		{
			_image = UIImage(named: "\(id)")
		}
		
		return _image!
	}
	
	init(id: Int, name: String)
	{
		self.id = id
		self.name = name
	}
	
	func preparePokemonInfo(calling completed: (pokemonInfo) -> ())
	{
		// If already downloaded, just returns the info
		if let info = info
		{
			completed(info)
		}
		else
		{
			var description = ""
			var type1 = Type.normal
			var type2: Type?
			var abilites = [Ability]()
			var stats = [Stat : Int]()
			
			// Requests the base information first
			Alamofire.request(self.url).responseJSON()
			{
				response in
				
				if let body = response.result.value as? [String : Any]
				{
					// Parses the stats first
					if let statDicts = body["stats"] as? [[String : Any]]
					{
						for statDict in statDicts
						{
							if let baseValue = statDict["base_stat"] as? Int
							{
								if let statInfoDict = statDict["stat"] as? [String : String]
								{
									if let statName = statInfoDict["name"]
									{
										if let stat = Stat.valueOf(string: statName)
										{
											stats[stat] = baseValue
										}
									}
								}
							}
						}
					}
					
					// Next parses the type(s)
					if let typeDicts = body["types"] as? [[String : Any]]
					{
						// TODO: Continue
					}
					
					// TODO: parse moves later
					// Description and abilites are in separate urls
				}
			}
		}
	}
}
