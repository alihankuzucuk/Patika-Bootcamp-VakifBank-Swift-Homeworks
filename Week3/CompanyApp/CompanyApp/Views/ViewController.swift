//
//  ViewController.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblCompanyBudget: UILabel!
    @IBOutlet weak var lblCompanyFoundation: UILabel!
    @IBOutlet weak var txtBudget: UITextField!
    
    var company: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtBudget.keyboardType = .decimalPad
        
        updateCompanyDetails()
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(listEmployees))
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addEmployee))
    }
    
    @IBAction func btnIncomeClicked(_ sender: Any) {
        if Constants.updateCompanyBudget(isIncome: true, amount: (Double(txtBudget.text!) ?? 0)) == .paymentSuccessful {
            showAlert(title: "Successful Payment", message: "Your budget increased amount of \(Double(txtBudget.text!) ?? 0)")
        }
        
        updateCompanyDetails()
    }
    
    @IBAction func btnExpenseClicked(_ sender: Any) {
        switch Constants.updateCompanyBudget(isIncome: false, amount: (Double(txtBudget.text!) ?? 0)) {
            case .inefficientBudget:
                showAlert(title: "Inefficient Budget", message: "Your company budget is inefficient to perform this action")
            case .paymentSuccessful:
                showAlert(title: "Successful Payment", message: "Your payment transaction completed")
        }
        
        updateCompanyDetails()
    }
    
    @IBAction func btnPaySalariesClicked(_ sender: Any) {
        switch Constants.updateCompanyBudget(isIncome: false, amount: Constants.totalSalaries()) {
            case .paymentSuccessful:
                showAlert(title: "Successful Payment", message: "Your employees salary paid on company budget")
            case .inefficientBudget:
                showAlert(title: "Inefficient Budget", message: "Your company budget is inefficient to perform this action")
        }
        
        updateCompanyDetails()
    }
    
    @objc func addEmployee(){
        performSegue(withIdentifier: "segueToAddEmployee", sender: nil)
    }
    
    @objc func listEmployees(){
        performSegue(withIdentifier: "segueToListEmployees", sender: nil)
    }
    
    func updateCompanyDetails() {
        lblCompanyName.text = Constants.companyName
        lblCompanyBudget.text = String(Constants.companyBudget)
        lblCompanyFoundation.text = String(Constants.companyFoundation)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertBtnOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertBtnOk)
        self.present(alert, animated: true, completion: nil)
    }
}

