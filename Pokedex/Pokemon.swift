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
	
	var info: PokemonInfo?
	
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
	
	// TODO: Never do JSON parsing like this again!
	func preparePokemonInfo(calling completed: @escaping (PokemonInfo) -> ())
	{
		// If already downloaded, just returns the info
		if let info = info
		{
			completed(info)
		}
		else
		{
			print("REQUESTING POKEMON DATA FOR \(self.name) at \(self.url)")
			
			var type1 = Type.normal
			var type2: Type?
			var stats = [Stat : Int]()
			
			/*
			Alamofire.request(self.url).responseString()
			{
				response in
				
				print("RESPONSE RECEIVED")
				print(response)
			}*/
			
			// TODO: Exception handling could be added
			// Requests the base information first
			Alamofire.request(self.url).responseJSON()
			{
				response in
				
				print("RESPONSE RECEIVED")
				if let body = response.result.value as? [String : AnyObject]
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
					print("STATS FOUND: \(stats)")
					
					// Next parses the type(s)
					if let typeDicts = body["types"] as? [[String : Any]]
					{
						for typeDict in typeDicts
						{
							if let slot = typeDict["slot"] as? Int
							{
								if let typeInfo = typeDict["type"] as? [String : String]
								{
									if let typeName = typeInfo["name"]
									{
										guard let type = Type(rawValue: typeName)
										else
										{
											print("Please check pokemon type definitions for \(typeName)")
											fatalError("Please check pokemon type definitions for \(typeName)")
										}
										
										if slot == 1
										{
											type1 = type
										}
										else
										{
											type2 = type
										}
									}
								}
							}
						}
					}
					print("TYPES FOUND: \(type1) \(type2)")
					
					// Description and abilites are behind separate urls
					// Finds the species url where to find the descriptions
					if let speciesInfo = body["species"] as? [String : String], let speciesUrl = speciesInfo["url"]
					{
						// Finds the ability information while at it
						var abilities = [(String, Bool, String)]() // name, hidden, url
						if let abilityDicts = body["abilities"] as? [[String : Any]]
						{
							for abilityDict in abilityDicts
							{
								if let isHidden = abilityDict["is_hidden"] as? Bool
								{
									if let abilityInfo = abilityDict["ability"] as? [String : String]
									{
										if let abilityName = abilityInfo["name"], let abilityUrl = abilityInfo["url"]
										{
											abilities.append((abilityName, isHidden, abilityUrl))
										}
									}
								}
							}
						}
						self.requestRemaining(url: speciesUrl, type1: type1, type2: type2, stats: stats, abilityInfo: abilities, calling: completed)
					}
					
					// TODO: parse moves later
				}
				else
				{
					print("ERROR")
					print(response)
				}
			}
		}
	}
	
	private func requestRemaining(url: String, type1: Type, type2: Type?, stats: [Stat : Int], abilityInfo: [(String, Bool, String)], calling completed: @escaping (PokemonInfo) -> ())
	{
		var descriptions = [String]()
		
		print("REQUESTING SPECIES")
		
		// Requests the descriptions first
		Alamofire.request(url).responseJSON()
		{
			response in
			
			print("SPECIES RESPONSE RECEIVED")
			if let body = response.result.value as? [String : Any]
			{
				if let descriptionDicts = body["flavor_text_entries"] as? [[String: Any]]
				{
					for descriptionDict in descriptionDicts
					{
						// Only english flavor text is included
						if let languageInfo = descriptionDict["language"] as? [String : String]
						{
							if languageInfo["name"] == "en"
							{
								if let text = descriptionDict["flavor_text"] as? String
								{
									let formattedText = text.replacingOccurrences(of: "\n", with: " ")
									if !descriptions.contains(formattedText)
									{
										descriptions.append(formattedText)
									}
								}
							}
						}
					}
				}
				print("DESCRIPTIONS FOUND: \(descriptions)")
			}
			
			// Next requests missing ability information
			self.requestRemainingAbilities(abilityInfo: abilityInfo, type1: type1, type2: type2, stats: stats, descriptions: descriptions, parsedAbilities: [], calling: completed)
		}
	}
	
	// Called recursively until all abilites are parsed
	private func requestRemainingAbilities(abilityInfo: [(String, Bool, String)], type1: Type, type2: Type?, stats: [Stat : Int], descriptions: [String], parsedAbilities: [(Ability, Bool)], calling completed: @escaping (PokemonInfo) -> ())
	{
		var remainingAbilityInfo = abilityInfo
		var abilities = parsedAbilities
		// Once there is nothing more to parse, informs the completion handler
		if remainingAbilityInfo.isEmpty
		{
			// Saves the info so that it doesn't need to be requested again
			self.info = PokemonInfo(descriptions: descriptions, abilities: parsedAbilities, baseStats: stats, type1: type1, type2: type2)
			completed(self.info!)
		}
		else
		{
			let (abilityName, isHidden, abilityUrl) = remainingAbilityInfo.popLast()!
			if let existingAbility = Ability.values[abilityName]
			{
				abilities.append((existingAbility, isHidden))
				// Continues recirsively
				self.requestRemainingAbilities(abilityInfo: remainingAbilityInfo, type1: type1, type2: type2, stats: stats, descriptions: descriptions, parsedAbilities: abilities, calling: completed)
			}
			else
			{
				print("REQUESTING ABILITY \(abilityName)")
				// Requests the ability information
				Alamofire.request(abilityUrl).responseJSON()
				{
					response in
					
					if let body = response.result.value as? [String : Any]
					{
						if let effectDicts = body["effect_entries"] as? [[String : Any]]
						{
							for effectDict in effectDicts
							{
								// Only english descriptions are included
								if let languageInfo = effectDict["language"] as? [String : String]
								{
									if let language = languageInfo["name"], language == "en"
									{
										if let description = effectDict["short_effect"] as? String
										{
											abilities.append((Ability(name: abilityName, description: description), isHidden))
										}
									}
								}
							}
						}
					}
					
					// Continues recirsively
					self.requestRemainingAbilities(abilityInfo: remainingAbilityInfo, type1: type1, type2: type2, stats: stats, descriptions: descriptions, parsedAbilities: abilities, calling: completed)
				}
			}
		}
	}
}
