//
//  CarsViewController.swift
//  FocusStartTestTask
//
//  Created by Олег Крылов on 14/05/2019.
//  Copyright © 2019 Oleg Krylov. All rights reserved.
//

import UIKit
import RealmSwift
let realm = try! Realm()
class CarsViewController: UIViewController {
    
    private lazy var carList = realm.objects(Car.self)
    
    @IBOutlet weak var carsTableView: UITableView!
    @IBAction func didTapOnAddButton(_ sender: Any) {
        addNewCar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carsTableView.reloadData()
    }
    
    private func addNewCar() {
        let newCar = Car()
        print(newCar)
        let alertController = self.makeAlertController(with: newCar) { textFields in
            newCar.manufacturer = textFields[0].text!
            newCar.model = textFields[1].text!
            newCar.year = Int(textFields[2].text!)!
            newCar.classType = textFields[3].text!
            newCar.type = textFields[4].text!
            try! realm.write {
                realm.add(newCar)
                self.carsTableView.reloadData()
            }
        }
        self.present(alertController, animated: true, completion:  nil)
    }
    
    private func change(with car: Car) {
        print(car)
        let alertController = self.makeAlertController(with: car) { textFields in
            try! realm.write{
                car.manufacturer = textFields[0].text!
                car.model = textFields[1].text!
                car.year = Int(textFields[2].text!)!
                car.classType = textFields[3].text!
                car.type = textFields[4].text!
                self.carsTableView.reloadData()
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func makeAlertController(with car: Car, completion: @escaping ([UITextField]) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Add New Car", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (manufacturer) in
            manufacturer.placeholder = "Manufacturer"
            manufacturer.text = car.manufacturer
        }
        alertController.addTextField { (model) in
            model.placeholder = "Model"
            model.text = car.model
        }
        alertController.addTextField { (year) in
            year.placeholder = "Year"
            year.keyboardType = .numberPad
            if car.year != 0 {
                year.text = String(car.year)
            }
        }
        alertController.addTextField { (classType) in
            classType.placeholder = "Class type"
            classType.text = car.classType
        }
        alertController.addTextField { (type) in
            type.placeholder = "Type"
            type.text = car.type
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        let createAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { (action) -> Void in
            completion(alertController.textFields ?? [])
        }
        alertController.addAction(createAction)
        return alertController
    }
}

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarsTableViewCell.reuseIdentifier, for: indexPath) as! CarsTableViewCell
        let car = carList[indexPath.row]
        cell.configure(with: car)
        return cell
    }
}

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            //Deletion will go here
            let carToBeDeleted = self.carList[indexPath.row]
            try! realm.write{
                realm.delete(carToBeDeleted)
                self.carsTableView.reloadData()
            }
        }
        
        let editAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Edit") { (editAction, indexPath) -> Void in
            // Editing will go here
            let carToBeUpdated = self.carList[indexPath.row]
            self.change(with: carToBeUpdated)
        }
        return [deleteAction, editAction]
    }
}
