//
//  ShoppingCart.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/10/21.
//

import Foundation

/// A list of products that user selected
struct ShoppingCart: Codable {
    var id = UUID()
    private(set) var products = [Product]()
}

extension ShoppingCart {
    func totalAmount() -> Decimal {
        products.reduce(0) {
            $0 + $1.selectedAmountInDecimal
        }
    }

    var isEmpty: Bool {
        products.isEmpty
    }
    
    /// Only one product left in the shopping cart
    var onlyOneLeft: Bool {
        products.count == 1
    }
    
    mutating func remove(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }

    mutating func addProduct(_ newProduct: Product) {
        guard var product = products.first(where: {$0.id == newProduct.id}) else {
            products.append(newProduct)
            return
        }
        product.selectedQuantity += newProduct.selectedQuantity
    }

    mutating func updateProduct(_ newProduct: Product) {
        guard let index = products.firstIndex(where: {$0.id == newProduct.id}) else {
            preconditionFailure("Error: Not able to find an product from the shopping cart")
        }
        products[index] = newProduct
    }
}
