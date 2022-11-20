//
//  Constants.swift
//  ZooApp
//
//  Created by Alihan KUZUCUK on 17.11.2022.
//

import UIKit
import CoreData

class Constants {
    struct ZooKeys {
        static let zooKey: String = "zoo"
        static let zooNameKey: String = "zooName"
        static let zooDailyWaterLimitKey: String = "zooDailyWaterLimit"
        static let zooBudgetKey: String = "zooBudget"
    }
    
    enum OperationStates {
        case operationSuccessful
        case inefficientBudget
        case inefficientDailyWaterLimit
    }
    
    static func createZoo(zooName: String, zooDailyWaterLimit: Int, zooBudget: Double) {
        let newZoo = [
            Self.ZooKeys.zooNameKey: zooName,
            Self.ZooKeys.zooDailyWaterLimitKey: zooDailyWaterLimit,
            Self.ZooKeys.zooBudgetKey: zooBudget
        ] as [String : Any]
        
        UserDefaults.standard.set(newZoo, forKey: Constants.ZooKeys.zooKey)
    }
    
    static var zooName: String {
        get {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            return zoo[Self.ZooKeys.zooNameKey] as? String ?? ""
        }
        set {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            let updateZoo = [
                Self.ZooKeys.zooNameKey: newValue,
                Self.ZooKeys.zooDailyWaterLimitKey: zoo[Self.ZooKeys.zooDailyWaterLimitKey] as? Int ?? 0,
                Self.ZooKeys.zooBudgetKey: zoo[Self.ZooKeys.zooBudgetKey] as? Double ?? 0
            ] as [String : Any]
            UserDefaults.standard.set(updateZoo, forKey: Self.ZooKeys.zooKey)
        }
    }
    
    static var zooDailyWaterLimit: Int {
        get {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            return zoo[Self.ZooKeys.zooDailyWaterLimitKey] as? Int ?? 0
        }
        set {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            let updateZoo = [
                Self.ZooKeys.zooNameKey: zoo[Self.ZooKeys.zooNameKey] as? String ?? "",
                Self.ZooKeys.zooDailyWaterLimitKey: newValue,
                Self.ZooKeys.zooBudgetKey: zoo[Self.ZooKeys.zooBudgetKey] as? Double ?? 0
            ] as [String : Any]
            UserDefaults.standard.set(updateZoo, forKey: Self.ZooKeys.zooKey)
        }
    }
    
    static var zooBudget: Double {
        get {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            return zoo[Self.ZooKeys.zooBudgetKey] as? Double ?? 0
        }
        set {
            var zoo: [String:Any] = [:]
            zoo = UserDefaults.standard.object(forKey: Self.ZooKeys.zooKey) as? [String:Any] ?? [:]
            let updateZoo = [
                Self.ZooKeys.zooNameKey: zoo[Self.ZooKeys.zooNameKey] as? String ?? "",
                Self.ZooKeys.zooDailyWaterLimitKey: zoo[Self.ZooKeys.zooDailyWaterLimitKey] as? Int ?? 0,
                Self.ZooKeys.zooBudgetKey: newValue
            ] as [String : Any]
            UserDefaults.standard.set(updateZoo, forKey: Self.ZooKeys.zooKey)
        }
    }
    
    @discardableResult
    static func updateZooBudget(isIncome: Bool, amount: Double) -> OperationStates {
        var newBudget: Double = Self.zooBudget
        
        if amount < 0 {
            return .inefficientBudget
        }
        
        if isIncome {
            newBudget += amount
        } else {
            if Self.zooBudget < amount {
                return .inefficientBudget
            }
            newBudget -= amount
        }
        
        let updateZoo = [
            Self.ZooKeys.zooNameKey: Self.zooName,
            Self.ZooKeys.zooBudgetKey: newBudget,
            Self.ZooKeys.zooDailyWaterLimitKey: Self.zooDailyWaterLimit
        ] as [String : Any]
        
        UserDefaults.standard.set(updateZoo, forKey: Self.ZooKeys.zooKey)
        
        return .operationSuccessful
    }
    
    @discardableResult
    static func updateZooDailyWaterLimit(isIncrease: Bool, amount: Int) -> OperationStates {
        var newDailyWaterLimit: Int = Self.zooDailyWaterLimit
        
        if amount < 0 {
            return .inefficientDailyWaterLimit
        }
        
        if isIncrease {
            newDailyWaterLimit += amount
        } else {
            if Self.zooDailyWaterLimit < amount {
                return .inefficientDailyWaterLimit
            }
            newDailyWaterLimit -= amount
        }
        
        let updateZoo = [
            Self.ZooKeys.zooNameKey: Self.zooName,
            Self.ZooKeys.zooBudgetKey: Self.zooBudget,
            Self.ZooKeys.zooDailyWaterLimitKey: newDailyWaterLimit
        ] as [String : Any]
        
        UserDefaults.standard.set(updateZoo, forKey: Self.ZooKeys.zooKey)
        
        return .operationSuccessful
    }
    
    struct ZooKeeper {
        var id: UUID
        var zooKeeperName: String
        var zooKeeperAge: Int
        
        var salary: Double {
            Double(((Constants.getResponsibleAnimalCount(zookeeperId: id) != 0 ? Double(Constants.getResponsibleAnimalCount(zookeeperId: id)) : 0.75) * 1000))
        }
    }
    
    static func getZooKeeperList() -> [Constants.ZooKeeper] {
        var zooKeeperList: [Constants.ZooKeeper] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ZooKeepers")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let zookeepers = try context.fetch(fetchRequest)
            
            if zookeepers.count > 0 {
                for zookeeper in zookeepers as! [NSManagedObject]{
                    
                    if let zookeeperId = zookeeper.value(forKey: "id") as? UUID,
                       let zookeeperName = zookeeper.value(forKey: "zookeeperName") as? String,
                       let zookeeperAge = zookeeper.value(forKey: "zookeeperAge") as? Int {
                        
                        let appendZooKeeper = Constants.ZooKeeper(id: zookeeperId, zooKeeperName: zookeeperName, zooKeeperAge: zookeeperAge)
                        
                        zooKeeperList.append(appendZooKeeper)
                        
                    }
                }
                return zooKeeperList
            }
            return []
        } catch {
            return []
        }
    }
    
    static func getZooKeeperBy(id zookeeperId:String) -> Constants.ZooKeeper? {
        var returnZookeeper: Constants.ZooKeeper? = nil
        getZooKeeperList().forEach { zookeeper in
            if zookeeper.id.uuidString == zookeeperId {
                returnZookeeper = zookeeper
            }
        }
        return returnZookeeper
    }
    
    struct Animal {
        var id: UUID
        var animalName: String
        var animalType: String
        var animalNoise: String
        var dailyWaterConsumption: Int
        var animalZookeeper: UUID
    }
    
    static func getAnimalList() -> [Constants.Animal] {
        var animalList: [Constants.Animal] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Animals")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let animals = try context.fetch(fetchRequest)
            
            if animals.count > 0 {
                for animal in animals as! [NSManagedObject]{
                    
                    if let animalId = animal.value(forKey: "id") as? UUID,
                       let animalName = animal.value(forKey: "animalName") as? String,
                       let animalType = animal.value(forKey: "animalType") as? String,
                       let animalNoise = animal.value(forKey: "animalNoise") as? String,
                       let dailyWaterConsumption = animal.value(forKey: "dailyWaterConsumption") as? Int,
                       let animalZookeeper = animal.value(forKey: "animalZookeeper") as? UUID {
                        
                        let appendAnimal = Constants.Animal(id: animalId, animalName: animalName, animalType: animalType, animalNoise: animalNoise, dailyWaterConsumption: dailyWaterConsumption, animalZookeeper: animalZookeeper)
                        
                        animalList.append(appendAnimal)
                        
                    }
                }
                return animalList
            }
            return []
        } catch {
            return []
        }
    }
    
    static func getResponsibleAnimalCount(zookeeperId: UUID) -> Int {
        var responsibleAnimalCounter: Int = 0
        getAnimalList().forEach { animal in
            if animal.animalZookeeper == zookeeperId {
                responsibleAnimalCounter += 1
            }
        }
        return responsibleAnimalCounter
    }
    
    static func totalSalaries() -> Double {
        let zooKeeperList = Self.getZooKeeperList()
        var totalSalary: Double = 0
        if zooKeeperList.count > 0 {
            zooKeeperList.forEach { zookeeper in
                totalSalary += zookeeper.salary
            }
        }
        return totalSalary
    }
    
    static func totalWaterConsumption() -> Int {
        let animalList = Self.getAnimalList()
        var totalWaterConsumption: Int = 0
        if animalList.count > 0 {
            animalList.forEach { animal in
                totalWaterConsumption += animal.dailyWaterConsumption
            }
        }
        return totalWaterConsumption
    }
}

