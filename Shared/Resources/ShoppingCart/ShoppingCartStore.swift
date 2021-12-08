//
//  ShoppingCartStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Guanglei Liu on 10/1/21.
//

import Foundation

enum ShoppingCartStoreError: Error {
    case fetchShoppingCart
}

@MainActor
class ShoppingCartStore: ObservableObject {
    @Published private var shoppingCart = ShoppingCart()
    private let shoppingCartService: ShoppingCartService

    init(service: ShoppingCartService) {
        self.shoppingCartService = service
    }

    var isEmpty: Bool {
        shoppingCart.isEmpty
    }
    
    var products: [Product] {
        shoppingCart.products
    }
    
    var totalAmount: String {
        shoppingCart.products.reduce(0) {
            $0 + $1.selectedAmountInDecimal
        }.stringValue
    }
    
//    func fetchShoppingCart() async {
//        do {
//            let shoppingCart = try await shoppingCartService.fetchShoppingCart()
//            self.shoppingCart = shoppingCart
//        } catch {
//            print("fetch shopping cart error: \(error)")
//        }
//    }
    
    func fetchShoppingCart() async -> ShoppingCartStoreError? {
        do {
            let shoppingCart = try await shoppingCartService.fetchShoppingCart()
            self.shoppingCart = shoppingCart
        } catch {
            return .fetchShoppingCart
        }
        return nil
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
    func addProduct(_ newProduct: Product) async {
        if shoppingCart.isEmpty {
            shoppingCart.addProduct(newProduct)
            await saveShoppingCart()
        } else {
            shoppingCart.addProduct(newProduct)
            await updateShoppingCart()
        }
    }
    
    /// Update existing `shoppingCart` on the sever
    func updateProduct(_ newProduct: Product) async {
        shoppingCart.updateProduct(newProduct)
        await updateShoppingCart()
    }
    
    /// Delete `shoppingCart` from server if deleting the last product, otherwise update it.
    func deleteProduct(at index: IndexSet) async {
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
