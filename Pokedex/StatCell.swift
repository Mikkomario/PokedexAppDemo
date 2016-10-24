//
//  StatCell.swift
//  Pokedex
//
//  Created by Mikko Hilpinen on 24.10.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

class StatCell: UITableViewCell
{
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var amountBar: UIProgressView!
	
	func configureCell(stat: Stat, amount: Int)
	{
		nameLabel.text = stat.rawValue
		amountLabel.text = "\(amount)"
		amountBar.setProgress(Float(amount) / Float(200.0), animated: false)
	}
	
	/*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	*/
}
