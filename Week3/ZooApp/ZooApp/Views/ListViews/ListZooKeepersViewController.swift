//
//  ListZooKeepersViewController.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit

class ListZooKeepersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var zookeepersList: [Constants.ZooKeeper] = []
    var selectedZooKeeperId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zookeepersList = Constants.getZooKeeperList()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToZooKeeperAnimals" {
            let destinationVC = segue.destination as! ZooKeeperAnimalsViewController
            destinationVC.selectedZooKeeperId = self.selectedZooKeeperId
        }
    }

}

extension ListZooKeepersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedZooKeeperId = zookeepersList[indexPath.row].id.uuidString
        performSegue(withIdentifier: "segueToZooKeeperAnimals", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.zookeepersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZooKeeperCell", for: indexPath) as! ListZooKeeperTableViewCell
        cell.lblName.text = zookeepersList[indexPath.row].zooKeeperName
        cell.lblAge.text = String(zookeepersList[indexPath.row].zooKeeperAge)
        cell.lblSalary.text = String(zookeepersList[indexPath.row].salary)
        cell.lblNumberOfAnimals.text = String(Constants.getResponsibleAnimalCount(zookeeperId: zookeepersList[indexPath.row].id)) + " Animal"
        return cell
    }
}
