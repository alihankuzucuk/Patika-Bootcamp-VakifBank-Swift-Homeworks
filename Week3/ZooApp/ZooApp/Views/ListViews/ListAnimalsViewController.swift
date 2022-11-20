//
//  ListAnimalsViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit
import AVFoundation

class ListAnimalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var animalsList: [Constants.Animal] = []
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalsList = Constants.getAnimalList()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }

}

extension ListAnimalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utterance = AVSpeechUtterance(string: animalsList[indexPath.row].animalNoise)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        utterance.rate = 0.45

        synthesizer.speak(utterance)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.animalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! ListAnimalTableViewCell
        cell.lblAnimalName.text = animalsList[indexPath.row].animalName
        cell.lblAnimalType.text = animalsList[indexPath.row].animalType
        cell.lblDailyWaterConsumption.text = String(animalsList[indexPath.row].dailyWaterConsumption)
        cell.lblZookeeper.text = String(Constants.getZooKeeperBy(id: animalsList[indexPath.row].animalZookeeper.uuidString)?.zooKeeperName ?? "")
        return cell
    }
}
