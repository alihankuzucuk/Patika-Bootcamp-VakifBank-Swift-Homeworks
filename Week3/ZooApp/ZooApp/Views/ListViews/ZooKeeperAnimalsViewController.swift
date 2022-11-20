//
//  ZooKeeperAnimalsViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit
import AVFoundation

class ZooKeeperAnimalsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listZookeeperAnimals: [Constants.Animal] = []
    var selectedZooKeeperId: String = ""
    
    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.getAnimalList().forEach({ animal in
            if animal.animalZookeeper.uuidString == selectedZooKeeperId {
                listZookeeperAnimals.append(animal)
            }
        })

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }

}

extension ZooKeeperAnimalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utterance = AVSpeechUtterance(string: listZookeeperAnimals[indexPath.row].animalNoise)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        utterance.rate = 0.45

        synthesizer.speak(utterance)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listZookeeperAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZooKeeperAnimalCell", for: indexPath) as! ZooKeeperAnimalsTableViewCell
        cell.lblAnimalName.text = listZookeeperAnimals[indexPath.row].animalName
        cell.lblAnimalType.text = listZookeeperAnimals[indexPath.row].animalType
        cell.lblDailyWaterConsumption.text = String(listZookeeperAnimals[indexPath.row].dailyWaterConsumption)
        return cell
    }
    
}
