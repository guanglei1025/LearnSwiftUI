//
//  LGProduct.swift
//  PinkCake
//
//  Created by Guanglei Liu on 10/29/19.
//

import Foundation
import SwiftUI

struct Product: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var description: String
    var imageURL: String

    var price: String
    var priceInDecimal: Decimal {
        Decimal.decimalValueOrZero(fromString: price)
    }

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    var category: Category
    enum Category: String, CaseIterable, Codable {
        case food = "Food"
        case drink = "Drink"
    }

    static var possibleNumbers: [String] {
        [ "1",
          "2",
          "3",
          "4",
          "5",
          "6"
        ]
    }
}
