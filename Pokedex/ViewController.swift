//
//  ViewController.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 27.9.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit
import AVFoundation

// Delegate, datasource, delegateflowlayoutwhatever
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{
	@IBOutlet weak var pokemonCollectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	private var pokemon = [Pokemon]()
	private var displayedPokemon = [Pokemon]()
	private var musicPlayer: AVAudioPlayer!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		parsePokemonCSV()
		displayedPokemon = pokemon
		
		searchBar.returnKeyType = .done
		searchBar.enablesReturnKeyAutomatically = false
		
		pokemonCollectionView.dataSource = self
		pokemonCollectionView.delegate = self
		searchBar.delegate = self
		
		initAudio()
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell
		{
			cell.setContent(displayedPokemon[indexPath.row])
			return cell
		}
		else
		{
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		let pokemon = displayedPokemon[indexPath.row]
		performSegue(withIdentifier: "ShowPokemonDetail", sender: pokemon)
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return displayedPokemon.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: 96, height: 96)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
	{
		if searchText == ""
		{
			displayedPokemon = pokemon
		}
		else
		{
			let filterStr = searchText.lowercased()
			displayedPokemon = pokemon.filter
			{
				pokemon in
				
				return pokemon.name.lowercased().range(of: filterStr) != nil
			}
		}
		
		pokemonCollectionView.reloadData()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
	{
		view.endEditing(true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// Sets the pokemon for the pokemon detail vc
		if segue.identifier == "ShowPokemonDetail"
		{
			if let detailsVC = segue.destination as? PokemonDetailVC, let pokemon = sender as? Pokemon
			{
				detailsVC.pokemon = pokemon
			}
		}
	}
	
	@IBAction func musicButtonPressed(_ sender: UIButton)
	{
		if musicPlayer.isPlaying
		{
			musicPlayer.pause()
			sender.alpha = 0.2
		}
		else
		{
			musicPlayer.play()
			sender.alpha = 1.0
		}
	}
	
	private func initAudio()
	{
		let path = Bundle.main.path(forResource: "pokemonMusic", ofType: "mp3")
		do
		{
			musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
			musicPlayer.prepareToPlay()
			musicPlayer.numberOfLoops = -1
			
			// In the exaple, the player is set on initially, but here it must be set separately (because testing)
			//musicPlayer.play()
		}
		catch
		{
			print(error)
		}
	}
	
	private func parsePokemonCSV()
	{
		let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
		do
		{
			let csv = try CSV(contentsOfURL: path!)
			let rows = csv.rows
			
			for row in rows
			{
				let id = Int(row["id"]!)!
				let name = row["identifier"]!
				
				pokemon.append(Pokemon(id: id, name: name))
			}
		}
		catch
		{
			fatalError()
		}
	}
}

