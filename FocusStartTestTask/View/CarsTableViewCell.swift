//
//  CarsTableViewCell.swift
//  FocusStartTestTask
//
//  Created by Олег Крылов on 14/05/2019.
//  Copyright © 2019 Oleg Krylov. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "carCell"
    @IBOutlet private weak var manufacturerLabel: UILabel!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var classTypeLabel: UILabel!
    
    func configure(with car: Car) {
        manufacturerLabel.text = "\(car.manufacturer)"
        modelLabel.text = "\(car.model)"
        yearLabel.text = "\(car.year)"
        typeLabel.text = "\(car.type)"
        classTypeLabel.text = "\(car.classType)"
    }
}
