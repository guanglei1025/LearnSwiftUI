//
//  ProductsAPI.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

protocol ProductService {
    func fetchAllProducts() async throws -> [Item]
    func fetchProduct(with id: String) async throws -> Item
}

final class ProductAPI: ProductService {
    private var webService: WebService

    init(webService: WebService) {
        self.webService = webService
    }

    func fetchAllProducts() async throws -> [Item] {
        guard let url = URL(string: "http://127.0.0.1:8080/products") else {
            throw WebServiceError.invalidURL
        }

        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode([Item].self, from: data)
        return decodedData 
    }

    func fetchProduct(with id: String) async throws -> Item {
        guard let url = URL(string: "http://127.0.0.1:8080/products/\(id)") else {
            throw WebServiceError.invalidURL
        }

        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode(Item.self, from: data)
        return decodedData
    }
}
