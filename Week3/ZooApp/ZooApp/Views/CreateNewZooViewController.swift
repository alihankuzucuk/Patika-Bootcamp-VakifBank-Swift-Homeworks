//
//  createNewZooViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit

class CreateNewZooViewController: UIViewController {

    
    @IBOutlet weak var txtZooName: UITextField!
    @IBOutlet weak var txtDailyWaterLimit: UITextField!
    @IBOutlet weak var txtZooBudget: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDailyWaterLimit.keyboardType = .numberPad
        txtZooBudget.keyboardType = .decimalPad
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @IBAction func btnSaveClicked(_ sender: Any) {
        if let dailyWaterLimit: Int = Int(txtDailyWaterLimit.text!),
           let zooBudget: Double = Double(txtZooBudget.text!) {
            
            Constants.createZoo(zooName: txtZooName.text!, zooDailyWaterLimit: dailyWaterLimit, zooBudget: zooBudget)
            
            performSegue(withIdentifier: "segueNewZooCreated", sender: nil)
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
