//
//  CarModel.swift
//  FocusStartTestTask
//
//  Created by Олег Крылов on 14/05/2019.
//  Copyright © 2019 Oleg Krylov. All rights reserved.
//

import Foundation
import RealmSwift

class Car: Object {
    
    @objc dynamic var manufacturer = ""
    @objc dynamic var model = ""
    @objc dynamic var year = 0
    @objc dynamic var classType = ""
    @objc dynamic var type = ""
}
