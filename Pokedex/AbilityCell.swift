//
//  AbilityCell.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 24.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

class AbilityCell: UITableViewCell
{
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var isHiddenLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	
	func configureCell(ability: Ability, isHidden: Bool)
	{
		print("SETTING \(isHidden ? "HIDDEN" : "") ABILITY \(ability.name.uppercased()): \(ability.description)")
		
		nameLabel.text = ability.name.capitalized
		descriptionTextView.text = ability.description
		isHiddenLabel.isHidden = !isHidden
	}
}
