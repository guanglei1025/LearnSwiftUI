//
//  Order.swift
//  LearnSwiftUI (iOS)
//
//  Created by Guanglei Liu on 10/1/21.
//

import Foundation

/// Order details of a single product
struct Order: Codable, Identifiable, Hashable  {
    var id = UUID()
    let product: Product
    var quantity: String

    init(from product: Product, quantity: String) {
        self.product = product
        self.quantity = quantity
    }
}

extension Order {
    func totalAmount() -> Decimal {
        product.priceInDecimal * Decimal.decimalValueOrZero(fromString: quantity)
    }
}
