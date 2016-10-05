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
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
	@IBOutlet weak var pokemonCollectionView: UICollectionView!

	private var pokemon = [Pokemon]()
	private var musicPlayer: AVAudioPlayer!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		parsePokemonCSV()
		
		pokemonCollectionView.dataSource = self
		pokemonCollectionView.delegate = self
		
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
			cell.setContent(pokemon[indexPath.row])
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
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return pokemon.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: 96, height: 96)
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
			musicPlayer.play()
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

