//
//  ViewController.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 27.9.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

// Delegate, datasource, delegateflowlayoutwhatever
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	@IBOutlet weak var pokemonCollectionView: UICollectionView!

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		pokemonCollectionView.dataSource = self
		pokemonCollectionView.delegate = self
		
		//pokemonCollectionView.size
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
			let pokemon = Pokemon(id: indexPath.row, name: "Pokemon")
			cell.setContent(pokemon: pokemon)
			
			return cell
		}
		else
		{
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		// TODO: Implement
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		// TODO
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		// TODO
		return 30
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: 96, height: 96)
	}
}

