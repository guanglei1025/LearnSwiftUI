//
//  ProductStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

@MainActor
final class ProductStore: ObservableObject {
    @Published var products = [Product]()
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
    typealias ItemCategory = Product.NewCategory

    var foods: [Product] {
        products.filter {
            $0.category == ItemCategory.food.rawValue
        }
    }

    var drinks: [Product] {
        products.filter {
            $0.category == ItemCategory.drink.rawValue
        }
    }

    /// Get a `Product` from `id`
    func getProduct(from productId: UUID) -> Product {
        guard let product = products.first(where: { $0.id == productId }) else {
            preconditionFailure("Doesn't have a matching product")
        }
        return product
    }
}

extension ProductStore {
    static func fakeItems() -> [Product] {
        [
            Product(id: UUID(uuidString: "AAEDBCB7-D32C-4F1E-89F8-C41E2D93CA32")!,
                 stockQuantity: 10,
                 price: "3.99",
                 imageURL: "https://lovingitvegan.com/wp-content/uploads/2018/11/Vegan-Eggnog-8.jpg",
                 description: "description",
                 name: "Name",
                 category: "food")
        ]
    }

    static func fakeOrder() -> Order {
        Order.init(from: UUID(uuidString: "AAEDBCB7-D32C-4F1E-89F8-C41E2D93CA32")!,
                   quantity: "10")
    }
}
