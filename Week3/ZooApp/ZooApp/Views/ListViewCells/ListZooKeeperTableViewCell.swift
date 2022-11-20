//
//  ListZooKeeperTableViewCell.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit

class ListZooKeeperTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblNumberOfAnimals: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
