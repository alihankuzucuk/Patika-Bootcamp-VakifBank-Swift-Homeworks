//
//  AddZooKeeperViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit
import CoreData

class AddZooKeeperViewController: UIViewController {
    
    @IBOutlet weak var txtZooKeeperName: UITextField!
    @IBOutlet weak var txtZooKeeperAge: UITextField!
    @IBOutlet weak var lblZooKeeperSalary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblZooKeeperSalary.text = String(750)
        // Every ZooKeepers first takes only 750 because they will have no responsible animal
        // Look at ZooKeeper list to see how salary calculates according to responsible animal count
        
        txtZooKeeperAge.keyboardType = .numberPad
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @IBAction func btnAddZooKeeperClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newZooKeeper = NSEntityDescription.insertNewObject(forEntityName: "ZooKeepers", into: context)
        newZooKeeper.setValue(txtZooKeeperName.text, forKey: "zookeeperName")
        newZooKeeper.setValue((Int(txtZooKeeperAge.text!) ?? 0), forKey: "zookeeperAge")
        
        newZooKeeper.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
}
