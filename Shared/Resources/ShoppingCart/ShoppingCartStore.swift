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
    
    func submitShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.submitShoppingCart(self.shoppingCart)
            self.shoppingCart = shoppingCart
        } catch {
            print("submit shopping cart error: \(error)")
        }
    }

    /// If `shoppingCart` is empty, it will save one on the server, otherwise, updated the `shoppingCart` on server.
    func addOrder(_ newOrder: Order) async {
        if shoppingCart.isEmpty {
            shoppingCart.addOrder(newOrder)
            await saveShoppingCart()
        } else {
            shoppingCart.addOrder(newOrder)
            await updateShoppingCart()
        }
    }
    
    /// Update existing `shoppingCart` on the sever
    func updateOrder(_ order: Order) async {
        shoppingCart.updateOrder(order)
        await updateShoppingCart()
    }
    
    /// Delete `shoppingCart` from server if deleting the last order, otherwise update it.
    func deleteOrder(index: IndexSet) async {
        if shoppingCart.onlyOneLeft {
            await deleteShoppingCart()
        } else {
            shoppingCart.remove(at: index)
            await updateShoppingCart()
        }
    }

    // MARK: - Private methods

    private func updateShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.updateShoppingCart(self.shoppingCart)
            self.shoppingCart = shoppingCart
        } catch {
            print("update shopping cart error: \(error)")
        }
    }

    private func saveShoppingCart() async {
        do {
            let shoppingCart = try await shoppingCartService.saveShoppingCart(self.shoppingCart)
            self.shoppingCart = shoppingCart
        } catch {
            print("save shopping cart error: \(error)")
        }
    }

    private func deleteShoppingCart() async {
        do {
            _ = try await shoppingCartService.deleteShoppingCart(self.shoppingCart)
            self.shoppingCart = ShoppingCart()
        } catch {
            print("delete shopping cart error: \(error)")
        }
    }
}
