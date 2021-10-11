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
    private let shoppingCartService: ShoppingCartService

    init(service: ShoppingCartService) {
        self.shoppingCartService = service
    }

    func fetchShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.fetchShoppingCart()
            self.shoppingCart = shoppingCart
            print(self.shoppingCart.orders)
        } catch {
            print("fetch products error: \(error)")
        }
    }

    func submitOrder() {
        //TODO:
    }

    /// Implement saving shopping cart, when the shoppingCart object is updated.
    func save() async {
        do {
            try await shoppingCartService.saveShoppingCart(self.shoppingCart)
        } catch {
            print("save error: \(error)")
        }
    }
}
