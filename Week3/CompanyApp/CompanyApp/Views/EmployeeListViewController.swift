//
//  EmployeeListViewController.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var employeeList: [Constants.Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        employeeList = Constants.getEmployeeList()
        
        self.tableView.reloadData()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Employee Name"
        navigationItem.searchController = searchController
    }

}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeListTableViewCell
        cell.lblEmployeeName.text = employeeList[indexPath.row].employeeName
        cell.lblAge.text = "Age: " + String(employeeList[indexPath.row].employeeAge)
        cell.lblEmployeeType.text = "Type: " + String(Constants.EmployeeType.getEmployeeType(byTypeId: employeeList[indexPath.row].employeeType.rawValue))
        cell.lblEmployeeSalary.text = "Salary: " + String(employeeList[indexPath.row].employeeSalary)
        return cell
    }
}

extension EmployeeListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        employeeList = []
        guard searchController.searchBar.text != "" else {
            employeeList = Constants.getEmployeeList()
            self.tableView.reloadData()
            return
        }
        Constants.getEmployeeList().forEach({ employee in
            if employee.employeeName.contains(searchText) {
                employeeList.append(employee)
            }
        })
        self.tableView.reloadData()
    }
}
