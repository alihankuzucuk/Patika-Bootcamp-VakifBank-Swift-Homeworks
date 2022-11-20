//
//  AddEmployeeViewController.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import UIKit
import CoreData

class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmployeeAge: UITextField!
    @IBOutlet weak var segmentedControlEmployeeType: UISegmentedControl!
    @IBOutlet weak var lblEmployeeSalary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmployeeAge.keyboardType = .numberPad
        
        segmentedControlEmployeeType.addTarget(self, action: #selector(segmentedControlEmployeeTypeValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func segmentedControlEmployeeTypeValueChanged() {
        lblEmployeeSalary.text = String(Constants.calculateEmployeeSalary(employeeAge: (Int(txtEmployeeAge.text!) ?? 0), employeeType: (segmentedControlEmployeeType.selectedSegmentIndex+1)))
    }

    @IBAction func btnAddEmployeeClicked(_ sender: Any) {
        segmentedControlEmployeeTypeValueChanged()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employees", into: context)
        newEmployee.setValue(txtEmployeeName.text, forKey: "employeeName")
        newEmployee.setValue((Int(txtEmployeeAge.text!) ?? 0), forKey: "employeeAge")
        newEmployee.setValue((segmentedControlEmployeeType.selectedSegmentIndex+1), forKey: "employeeType")
        newEmployee.setValue(Constants.calculateEmployeeSalary(employeeAge: (Int(txtEmployeeAge.text!) ?? 0), employeeType: (segmentedControlEmployeeType.selectedSegmentIndex+1)), forKey: "employeeSalary")
        
        newEmployee.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertBtnOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertBtnOk)
        self.present(alert, animated: true, completion: nil)
    }
}
