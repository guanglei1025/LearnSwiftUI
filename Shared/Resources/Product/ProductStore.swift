//
//  ProductStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

enum ProductStoreError: Error {
    case fetchAllProducts
}

@MainActor
final class ProductStore: ObservableObject {
    @Published var products = [Product]()
    private let service: ProductService

    init(service: ProductService) {
        self.service = service
    }

    func fetchProducts() async -> ProductStoreError? {
        do {
            let items = try await service.fetchAllProducts()
            self.products = items
        } catch {
            return ProductStoreError.fetchAllProducts
        }
        return nil
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
}

extension ProductStore {
    static func fakeItems() -> [Product] {
        [
            Product(id: UUID(uuidString: "AAEDBCB7-D32C-4F1E-89F8-C41E2D93CA32")!,
                    stockQuantity: 10,
                    selectedQuantity: 1,
                    price: "3.99",
                    imageURL: "https://lovingitvegan.com/wp-content/uploads/2018/11/Vegan-Eggnog-8.jpg",
                    description: "description",
                    name: "Name",
                    isFeatured: true,
                    category: "food")
        ]
    }
    
    static func fakeProduct() -> Product {
        fakeItems()[0]
    }
}
