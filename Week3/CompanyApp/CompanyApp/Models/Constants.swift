//
//  Constants.swift
//  CompanyApp
//
//  Created by Alihan KUZUCUK on 15.11.2022.
//

import Foundation
import UIKit
import CoreData

class Constants {
    struct CompanyKeys {
        static let companyKey: String = "company"
        static let companyNameKey: String = "companyName"
        static let companyBudgetKey: String = "companyBudget"
        static let companyFoundationKey: String = "companyFoundation"
    }
    
    struct Employee {
        var id: UUID
        var employeeName: String
        var employeeAge: Int
        var employeeType: EmployeeType
        var employeeSalary: Double
    }
    
    enum EmployeeType: Int {
        case junior = 1, middle, senior
        
        static func getEmployeeType(byTypeId: Int) -> String {
            switch byTypeId {
                case 1:
                    return "Junior"
                case 2:
                    return "Middle"
                case 3:
                    return "Senior"
                default:
                    return "None"
            }
        }
    }
    
    enum OperationStates {
        case paymentSuccessful
        case inefficientBudget
    }
    
    static var companyName: String {
        get {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            return company[Self.CompanyKeys.companyNameKey] as? String ?? ""
        }
        set {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            let updateCompany = [
                Self.CompanyKeys.companyNameKey: newValue,
                Self.CompanyKeys.companyBudgetKey: company[Self.CompanyKeys.companyBudgetKey] as? Double ?? 0,
                Self.CompanyKeys.companyFoundationKey: company[Self.CompanyKeys.companyFoundationKey] as? Int ?? 0
            ] as [String : Any]
            UserDefaults.standard.set(updateCompany, forKey: Self.CompanyKeys.companyKey)
        }
    }
    
    static var companyBudget: Double {
        get {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            return company[Self.CompanyKeys.companyBudgetKey] as? Double ?? 0
        }
        set {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            let updateCompany = [
                Self.CompanyKeys.companyNameKey: company[Self.CompanyKeys.companyNameKey] as? String ?? "",
                Self.CompanyKeys.companyBudgetKey: newValue,
                Self.CompanyKeys.companyFoundationKey: company[Self.CompanyKeys.companyFoundationKey] as? Int ?? 0
            ] as [String : Any]
            UserDefaults.standard.set(updateCompany, forKey: Self.CompanyKeys.companyKey)
        }
    }
    
    static var companyFoundation: Int {
        get {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            return company[Self.CompanyKeys.companyFoundationKey] as? Int ?? 0
        }
        set {
            var company: [String:Any] = [:]
            company = UserDefaults.standard.object(forKey: Self.CompanyKeys.companyKey) as? [String:Any] ?? [:]
            let updateCompany = [
                Self.CompanyKeys.companyNameKey: company[Self.CompanyKeys.companyNameKey] as? String ?? "",
                Self.CompanyKeys.companyBudgetKey: company[Self.CompanyKeys.companyBudgetKey] as? Double ?? 0,
                Self.CompanyKeys.companyFoundationKey: newValue
            ] as [String : Any]
            UserDefaults.standard.set(updateCompany, forKey: Self.CompanyKeys.companyKey)
        }
    }
    
    static func createCompany(companyName: String, companyBudget: Double, companyFoundation: Int) {
        let newCompany = [
            "companyName": companyName,
            "companyBudget": companyBudget,
            "companyFoundation": companyFoundation
        ] as [String : Any]
        
        UserDefaults.standard.set(newCompany, forKey: Constants.CompanyKeys.companyKey)
    }
    
    @discardableResult
    static func updateCompanyBudget(isIncome: Bool, amount: Double) -> OperationStates {
        var newBudget: Double = Self.companyBudget
        
        if amount < 0 {
            return .inefficientBudget
        }
        
        if isIncome {
            newBudget += amount
        } else {
            if Self.companyBudget < amount {
                return .inefficientBudget
            }
            newBudget -= amount
        }
        
        let updateCompany = [
            Self.CompanyKeys.companyNameKey: Self.companyName,
            Self.CompanyKeys.companyBudgetKey: newBudget,
            Self.CompanyKeys.companyFoundationKey: Self.companyFoundation
        ] as [String : Any]
        
        UserDefaults.standard.set(updateCompany, forKey: Self.CompanyKeys.companyKey)
        
        return .paymentSuccessful
    }
    
    static func calculateEmployeeSalary(employeeAge: Int, employeeType: Int) -> Double {
        return Double(employeeAge * employeeType * 1000)
    }
    
    static func getEmployeeList() -> [Constants.Employee] {
        var employeeList: [Constants.Employee] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let employees = try context.fetch(fetchRequest)
            
            if employees.count > 0 {
                for employee in employees as! [NSManagedObject]{
                    
                    if let employeeId = employee.value(forKey: "id") as? UUID,
                       let employeeName = employee.value(forKey: "employeeName") as? String,
                       let employeeAge = employee.value(forKey: "employeeAge") as? Int,
                       let employeeType = employee.value(forKey: "employeeType") as? Int,
                       let employeeSalary = employee.value(forKey: "employeeSalary") as? Double {
                        
                        let appendEmployee = Constants.Employee(id: employeeId, employeeName: employeeName, employeeAge: employeeAge, employeeType: Constants.EmployeeType(rawValue: employeeType) ?? .junior, employeeSalary: employeeSalary)
                        
                        employeeList.append(appendEmployee)
                        
                    }
                }
                return employeeList
            }
            return []
        } catch {
            return []
        }
    }
    
    static func totalSalaries() -> Double {
        let employeeList = Self.getEmployeeList()
        var totalSalary: Double = 0
        if employeeList.count > 0 {
            employeeList.forEach { employee in
                totalSalary += employee.employeeSalary
            }
        }
        return totalSalary
    }
    
}
