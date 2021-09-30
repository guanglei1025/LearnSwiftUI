//
//  ProductStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

@MainActor
final class ProductStore: ObservableObject {
    @Published var products = [Item]()
    private let service: ProductService

    init(service: ProductService) {
        self.service = service
    }

    func fetchProducts() async {
        do {
            let items = try await service.fetchAllProducts()
            self.products = items
        } catch {
            print("fetch products error: \(error)")
        }
    }

    func fetchProduct() async {
        do {
            let id = "AAEDBCB7-D32C-4F1E-89F8-C41E2D93CA32"
            let item = try await service.fetchProduct(with: id)
            print(item)
        } catch {
            print("fetch product error: \(error)")
        }
    }
}

extension ProductStore {
    typealias ItemCategory = Item.NewCategory

    var foods: [Item] {
        products.filter {
            $0.category == ItemCategory.food.rawValue
        }
    }

    var drinks: [Item] {
        products.filter {
            $0.category == ItemCategory.drink.rawValue
        }
    }
}
