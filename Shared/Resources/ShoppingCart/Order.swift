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
    let productId: UUID
    var quantity: String

    init(from productId: UUID, quantity: String) {
        self.productId = productId
        self.quantity = quantity
    }
}

extension Order {
    func totalAmount() -> Decimal {
//        product.priceInDecimal * Decimal.decimalValueOrZero(fromString: quantity)
        //FIXME:
        return 12.0
    }
}
