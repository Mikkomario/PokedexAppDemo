//
//  StatType.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import Foundation

enum Stat: String
{
	case HP
	case Att
	case Def
	case SpAtt
	case SpDef
	case Spd
	
	static func valueOf(string: String) -> Stat?
	{
		if let stat = Stat(rawValue: string)
		{
			return stat
		}
		else
		{
			switch string.lowercased()
			{
			case "hp": return .HP
			case "attack": return .Att
			case "defense": return .Def
			case "special-attack": return .SpAtt
			case "special-defense": return .SpDef
			case "speed": return .Spd
			default: return nil
			}
		}
	}
}
