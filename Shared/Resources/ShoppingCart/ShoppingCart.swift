//
//  ShoppingCart.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/10/21.
//

import Foundation

/// A list of orders that user selected
struct ShoppingCart: Codable {
    var id = UUID()
    private(set) var orders = [Order]()
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

    // Add order to shopping cart based on different condition
    mutating func addOrder(_ newOrder: Order) {
        // If the product of the new order already exists in the orders,
        // then get the sum of quantity as the updated quantity of the order for this specific product
        if let index = orders.firstIndex(where: {$0.productId == newOrder.productId}) {
            guard let previousQuantity = Int(orders[index].quantity), let newQuantity = Int(newOrder.quantity) else {
                return
            }
            let updatedQuantity = previousQuantity + newQuantity
            orders[index].quantity = String(updatedQuantity)
        } else {
            // If not, then directly add new order to orders
            orders.append(newOrder)
        }
    }

    mutating func updateOrder(_ order: Order) {
        guard let index = indexForOrder(with: order.productId) else {
            return
        }
        orders[index] = order
    }

    func indexForOrder(with id: UUID) -> Int? {
        orders.firstIndex { $0.productId == id }
    }

}

