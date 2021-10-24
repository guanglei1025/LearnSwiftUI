//
//  ShoppingCartStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Guanglei Liu on 10/1/21.
//

import Foundation

@MainActor
class ShoppingCartStore: ObservableObject {
    @Published var shoppingCart = ShoppingCart()
    @Published var hasShoppingCart = false
    private let shoppingCartService: ShoppingCartService

    init(service: ShoppingCartService) {
        self.shoppingCartService = service
    }

    func fetchShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.fetchShoppingCart()
            self.shoppingCart = shoppingCart
            print(self.shoppingCart.orders)

            hasShoppingCart = shoppingCart.orders.isEmpty ? false : true
        } catch {
            print("fetch products error: \(error)")
        }
    }

    func submitOrder() {
        //TODO:
    }

    /// Implement saving shopping cart
    func save() async {
        do {
            try await shoppingCartService.saveShoppingCart(self.shoppingCart)
        } catch {
            print("save error: \(error)")
        }
    }
}
