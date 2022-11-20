//
//  EmployeeListTableViewCell.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmployeeType: UILabel!
    @IBOutlet weak var lblEmployeeSalary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
