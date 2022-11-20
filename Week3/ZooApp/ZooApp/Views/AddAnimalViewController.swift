//
//  AddAnimalViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit
import CoreData

class AddAnimalViewController: UIViewController {

    @IBOutlet weak var txtAnimalName: UITextField!
    @IBOutlet weak var txtDailyWaterConsumption: UITextField!
    @IBOutlet weak var txtAnimalNoise: UITextField!
    @IBOutlet weak var btnPullDownAnimalType: UIButton!
    @IBOutlet weak var pickerViewZooKeepers: UIPickerView!
    
    var animalTypes: [String] = ["Leo", "Snake", "Turtle", "Dog", "Cat", "Bird"]
    var selectedAnimalType: String = ""
    var zooKeeperList: [Constants.ZooKeeper] = []
    var selectedZooKeeper: [Constants.ZooKeeper] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        let btnPullDownAnimalTypeMenuAction = {(action: UIAction) in
            self.selectedAnimalType = action.title
        }
        
        var pulldownAnimalActions: [UIMenuElement] = [UIAction(title: "Choose Animal Type", state: .on, handler: btnPullDownAnimalTypeMenuAction)]
        
        animalTypes.forEach({ animalType in
            pulldownAnimalActions.append(UIAction(title: animalType, handler: btnPullDownAnimalTypeMenuAction))
        })
        
        btnPullDownAnimalType.menu = UIMenu(children: pulldownAnimalActions)
        btnPullDownAnimalType.showsMenuAsPrimaryAction = true
        btnPullDownAnimalType.changesSelectionAsPrimaryAction = true
        
        zooKeeperList = Constants.getZooKeeperList()
        
        if zooKeeperList.count <= 0 {
            showAlert(title: "There is no ZooKeeper", message: "Please first add a ZooKeeper to assign animal")
        }
        
        pickerViewZooKeepers.delegate = self
        pickerViewZooKeepers.dataSource = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertBtnOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertBtnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnAddAnimalClicked(_ sender: Any) {
        if selectedAnimalType != "" &&
            selectedAnimalType != "Choose Animal Type" &&
            selectedZooKeeper.count > 0 {
            
            if let newAnimalName: String = txtAnimalName.text,
               let newAnimalNoise: String = txtAnimalNoise.text,
               let newAnimalDailyWaterConsumption: Int = Int(txtDailyWaterConsumption.text!) {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let newAnimal = NSEntityDescription.insertNewObject(forEntityName: "Animals", into: context)
                newAnimal.setValue(newAnimalName, forKey: "animalName")
                newAnimal.setValue(selectedAnimalType, forKey: "animalType")
                newAnimal.setValue(newAnimalNoise, forKey: "animalNoise")
                newAnimal.setValue(newAnimalDailyWaterConsumption, forKey: "dailyWaterConsumption")
                newAnimal.setValue(selectedZooKeeper[0].id, forKey: "animalZookeeper")
                
                newAnimal.setValue(UUID(), forKey: "id")
                
                do {
                    try context.save()
                    
                    self.navigationController?.popViewController(animated: true)
                } catch {
                    
                }
            }
        } else {
            showAlert(title: "Incorrect Data", message: "Please enter all information")
        }
    }
    
}

extension AddAnimalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        zooKeeperList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return zooKeeperList[row].zooKeeperName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedZooKeeper.removeAll(keepingCapacity: false)
        selectedZooKeeper.append(zooKeeperList[row])
    }
}
