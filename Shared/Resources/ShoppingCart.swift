//
//  ShoppingCart.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/10/21.
//

import Foundation

/// A list of orders that user selected
struct ShoppingCart: Codable {
    var orders = [Order]()
}

extension ShoppingCart {
    func totalAmount() -> Decimal {
        orders.reduce(0) {
            $0 + $1.totalAmount()
        }
    }

    mutating func remove(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
    }
}

/// Order details of a single product
struct Order: Codable, Identifiable, Hashable {
    var id = UUID()
    var product: Product
    var quantity: Int

    init(from product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}

extension Order {
    func totalAmount() -> Decimal {
        product.priceInDecimal * Decimal(quantity)
    }
}
