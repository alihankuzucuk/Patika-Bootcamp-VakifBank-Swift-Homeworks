//
//  ViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblZooName: UILabel!
    @IBOutlet weak var lblZooBudget: UILabel!
    @IBOutlet weak var lblZooDailyWaterLimit: UILabel!
    @IBOutlet weak var txtZooBudget: UITextField!
    @IBOutlet weak var txtDailyWaterLimit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtZooBudget.keyboardType = .decimalPad
        txtDailyWaterLimit.keyboardType = .numberPad
        
        updateZooDetails()
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addToZoo))
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "ZooKeeper List", image: UIImage(systemName: "list.dash"), handler: { (_) in
                    self.performSegue(withIdentifier: "segueListZooKeepers", sender: nil)
                }),
                UIAction(title: "Animal List", image: UIImage(systemName: "list.dash"), handler: { (_) in
                    self.performSegue(withIdentifier: "segueListAnimals", sender: nil)
                })
            ]
        }

        var listMenu: UIMenu {
            return UIMenu(title: "List menu", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Menu", image: nil, primaryAction: nil, menu: listMenu)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func updateZooDetails() {
        lblZooName.text = Constants.zooName
        lblZooBudget.text = String(Constants.zooBudget)
        lblZooDailyWaterLimit.text = String(Constants.zooDailyWaterLimit)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func addToZoo() {
        performSegue(withIdentifier: "segueAddToZoo", sender: nil)
    }
    
    @IBAction func btnZooBudgetIncomeClicked(_ sender: Any) {
        if Constants.updateZooBudget(isIncome: true, amount: (Double(txtZooBudget.text!) ?? 0)) == .operationSuccessful {
            showAlert(title: "Successful Payment", message: "Your budget increased amount of \(Double(txtZooBudget.text!) ?? 0)")
        }
        
        updateZooDetails()
    }
    
    @IBAction func btnZooBudgetExpenseClicked(_ sender: Any) {
        switch Constants.updateZooBudget(isIncome: false, amount: (Double(txtZooBudget.text!) ?? 0)) {
            case .inefficientBudget:
                showAlert(title: "Inefficient Budget", message: "Your company budget is inefficient to perform this action")
            case .operationSuccessful:
                showAlert(title: "Successful Payment", message: "Your payment transaction completed")
            default:
                showAlert(title: "Error", message: "Wrong operation state encountered while expensing zoo budget")
        }
        
        updateZooDetails()
    }
    
    @IBAction func btnPaySalariesClicked(_ sender: Any) {
        switch Constants.updateZooBudget(isIncome: false, amount: Constants.totalSalaries()) {
            case .inefficientBudget:
                showAlert(title: "Inefficient Budget", message: "Your company budget is inefficient to perform this action")
            case .operationSuccessful:
                showAlert(title: "Successful Payment", message: "Your payment transaction completed")
            default:
                showAlert(title: "Error", message: "Wrong operation state encountered while expensing zoo budget")
        }
        
        updateZooDetails()
    }
    
    @IBAction func btnDailyWaterLimitIncreaseClicked(_ sender: Any) {
        if Constants.updateZooDailyWaterLimit(isIncrease: true, amount: (Int(txtDailyWaterLimit.text!) ?? 0)) == .operationSuccessful {
            showAlert(title: "Successful Increase", message: "Your daily water limit increased amount of \(Int(txtDailyWaterLimit.text!) ?? 0)")
        }
        
        updateZooDetails()
    }
    
    @IBAction func btnDailyWaterLimitDecreaseClicked(_ sender: Any) {
        switch Constants.updateZooDailyWaterLimit(isIncrease: false, amount: (Int(txtDailyWaterLimit.text!) ?? 0)) {
            case .inefficientDailyWaterLimit:
                showAlert(title: "Inefficient Daily Water Limit", message: "Your daily water limit is inefficient to perform this action")
            case .operationSuccessful:
                showAlert(title: "Successful Decrease", message: "Your daily water limit decreased amount of \(Int(txtDailyWaterLimit.text!) ?? 0)")
            default:
                showAlert(title: "Error", message: "Wrong operation state encountered while decreasing daily water limit")
        }
        
        updateZooDetails()
    }
    
    @IBAction func btnWaterAnimalsClicked(_ sender: Any) {
        switch Constants.updateZooDailyWaterLimit(isIncrease: false, amount: Constants.totalWaterConsumption()) {
            case .inefficientDailyWaterLimit:
                showAlert(title: "Inefficient Daily Water Limit", message: "Your daily water limit is inefficient to perform this action")
            case .operationSuccessful:
                showAlert(title: "Successful Decrease", message: "Your daily water limit decreased amount of \(Constants.totalWaterConsumption())")
            default:
                showAlert(title: "Error", message: "Wrong operation state encountered while decreasing daily water limit")
        }
        
        updateZooDetails()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertBtnOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertBtnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
}
