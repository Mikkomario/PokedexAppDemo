//
//  PokemonCellCollectionViewCell.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 5.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell
{
	@IBOutlet weak var thumbImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	required init?(coder: NSCoder)
	{
		super.init(coder: coder)
		
		layer.cornerRadius = 5.0
	}
	
	func setContent(_ pokemon: Pokemon)
	{
		thumbImageView.image = UIImage(named: "\(pokemon.id)")
		nameLabel.text = pokemon.name.capitalized
	}
}
