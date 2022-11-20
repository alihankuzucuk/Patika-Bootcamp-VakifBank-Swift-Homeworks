//
//  CreateCompanyViewController.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import UIKit

class CreateCompanyViewController: UIViewController {

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtCompanyBudget: UITextField!
    @IBOutlet weak var txtCompanyFoundation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCompanyBudget.keyboardType = .decimalPad
        txtCompanyFoundation.keyboardType = .numberPad
    }

    @IBAction func btnCompanySaveClicked(_ sender: Any) {
        if let companyBudget: Double = Double(txtCompanyBudget.text!) {
            if let companyFoundation: Int = Int(txtCompanyFoundation.text!) {
                
                Constants.createCompany(companyName: txtCompanyName.text!, companyBudget: companyBudget, companyFoundation: companyFoundation)
                
                performSegue(withIdentifier: "segueNewCompanyCreated", sender: nil)
            }
        }
    }
}
