//
//  CarListViewModel.swift
//  Assignment
//
//  Created by RAMESH NATARAJAN on 2/23/20.
//  Copyright © 2020 RAMESH NATARAJAN. All rights reserved.
//

import UIKit
import Foundation

struct CarListViewModel: Codable {
    var listings: [listingModel]?
}

struct listingModel: Codable {
    var make: String?
    var mileage: Int?
    var model: String?
    var listPrice: Float?
    var dealer: dealerModel?
    var images: imagesModel?
    var onePriceArrows: [onePriceArrows]?
}

struct imagesModel: Codable {
    var baseUrl: String?
}

struct dealerModel: Codable {
    var city: String?
    var phone: String?
    var state: String?
    var zip: String?
}

struct onePriceArrows: Codable {
    var iconUrl: String?
    var text: String?
}
