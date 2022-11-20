//
//  ListAnimalTableViewCell.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit

class ListAnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAnimalName: UILabel!
    @IBOutlet weak var lblAnimalType: UILabel!
    @IBOutlet weak var lblDailyWaterConsumption: UILabel!
    @IBOutlet weak var lblZookeeper: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
