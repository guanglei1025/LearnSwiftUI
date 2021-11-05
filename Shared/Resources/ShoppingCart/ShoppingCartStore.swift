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
        } catch {
            print("fetch shopping cart error: \(error)")
        }
    }

    func deleteShoppingCart() async {
        do {
            _ = try await shoppingCartService.deleteShoppingCart(self.shoppingCart)
            self.shoppingCart = ShoppingCart()
        } catch {
            print("delete shopping cart error: \(error)")
        }
    }

    func updateShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.updateShoppingCart(self.shoppingCart)
            self.shoppingCart = shoppingCart
        } catch {
            print("update shopping cart error: \(error)")
        }
    }

    func submitOrder() {
        //TODO:
    }
}
