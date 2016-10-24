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
	@IBOutlet weak var statsTable: UITableView!
	@IBOutlet weak var abilityTable: UITableView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionView: UITextView!
	@IBOutlet weak var secondaryTypeLabel: UILabel!
	@IBOutlet weak var primaryTypeLabel: UILabel!
	@IBOutlet weak var pokemonImageView: UIImageView!
	
	var pokemon: Pokemon!
	private let abilityDataSource = AbilityTableDS()
	private let statDataSource = StatTableDS()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		nameLabel.text = pokemon.name.capitalized
		pokemonImageView.image = pokemon.image
		
		descriptionView.text = "Retrieving information..."
		primaryTypeLabel.text = "..."
		secondaryTypeLabel.text = nil
		
		// Downloads pokemon data if necessary, updates the UI afterwards
		pokemon.preparePokemonInfo()
		{
			info in
			
			if !info.descriptions.isEmpty
			{
				self.descriptionView.text = info.descriptions[Int(arc4random_uniform(UInt32(info.descriptions.count)))]
			}
			else
			{
				self.descriptionView.text = "No data available"
			}
			self.primaryTypeLabel.text = info.primaryType.rawValue.capitalized
			self.secondaryTypeLabel.text = info.secondaryType?.rawValue.capitalized
			
			// Sets abilities
			self.abilityDataSource.abilities = info.abilities
			self.abilityTable.rowHeight = UITableViewAutomaticDimension
			self.abilityTable.estimatedRowHeight = 64
			self.abilityTable.dataSource = self.abilityDataSource
			self.abilityTable.reloadData()
			
			// Sets stats
			self.statDataSource.stats = info.baseStats
			self.statsTable.dataSource = self.statDataSource
			self.statsTable.reloadData()
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

private class AbilityTableDS: NSObject, UITableViewDataSource
{
	var abilities = [(Ability, Bool)]()
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return abilities.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		if let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell", for: indexPath) as? AbilityCell
		{
			let (ability, hidden) = abilities[indexPath.row]
			cell.configureCell(ability: ability, isHidden: hidden)
			return cell
		}
		else
		{
			fatalError()
		}
	}
}

private class StatTableDS: NSObject, UITableViewDataSource
{
	private static let statOrder: [Stat] = [.HP, .Def, .SpDef, .Att, .SpAtt, .Spd]
	var stats = [Stat : Int]()
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return StatTableDS.statOrder.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		if let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath) as? StatCell
		{
			let stat = StatTableDS.statOrder[indexPath.row]
			let amount = stats[stat]
			cell.configureCell(stat: stat, amount: amount == nil ? 0 : amount!)
			return cell
		}
		else
		{
			fatalError()
		}
	}
}
