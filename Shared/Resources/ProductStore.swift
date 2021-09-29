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
}
