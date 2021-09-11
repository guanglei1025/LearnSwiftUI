//
//  ShoppingCart.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/10/21.
//

import Foundation

/// A list of orders that user selected
struct ShoppingCartNew: Codable {
    var id: Int
    var orders: [Order]
}

/// Order details of a single product
struct Order: Codable {
    var productId: Int
    var quantity: Int
}
