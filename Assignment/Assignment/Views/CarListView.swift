//
//  CarListView.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import Foundation
import UIKit

struct CarListView {
    var carName: String
    var carPrice: Float
    var carMiles: Int
    var carPlace: String
    var phone: String
    var carImage: UIImage
    
    func createCarModel() -> CarListView {
        return CarListView(carName: carName,
                           carPrice: carPrice,
                           carMiles: carMiles,
                           carPlace: carPlace,
                           phone: phone,
                           carImage: carImage)
    }
}


struct CarDetailView {
    
    var iconImage: UIImage
    var snapshotText: String
    
    func createCarDetailModel() -> CarDetailView {
        return CarDetailView(iconImage: iconImage,
                           snapshotText: snapshotText)
    }
}
