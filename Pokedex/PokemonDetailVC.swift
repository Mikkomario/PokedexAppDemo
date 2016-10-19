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
	
	var pokemon: Pokemon!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		nameLabel.text = pokemon.name
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
