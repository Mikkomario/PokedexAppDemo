//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 19.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionView: UITextView!
	@IBOutlet weak var secondaryTypeLabel: UILabel!
	@IBOutlet weak var primaryTypeLabel: UILabel!
	@IBOutlet weak var pokemonImageView: UIImageView!
	
	var pokemon: Pokemon!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		nameLabel.text = pokemon.name.capitalized
		pokemonImageView.image = pokemon.image
		
		// Downloads pokemon data if necessary, updates the UI afterwards
		pokemon.preparePokemonInfo()
		{
			info in
			
			descriptionView.text = info.description
			primaryTypeLabel.text = info.primaryType.rawValue
			secondaryTypeLabel.text = info.secondaryType?.rawValue
		}
    }

	@IBAction func backButtonPressed(_ sender: UIButton)
	{
		dismiss(animated: true, completion: nil)
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
