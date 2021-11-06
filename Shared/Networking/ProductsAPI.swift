//
//  ProductsAPI.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

protocol ProductService {
    func fetchAllProducts() async throws -> [Product]
    func fetchProduct(with id: String) async throws -> Product
}

final class ProductAPI: ProductService {
    private var webService: WebService
    private let productsBaseURL = "http://127.0.0.1:8080/products"
    
    init(webService: WebService) {
        self.webService = webService
    }

    func fetchAllProducts() async throws -> [Product] {
        guard let url = URL(string: productsBaseURL) else {
            throw WebServiceError.invalidURL
        }

        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode([Product].self, from: data)
        return decodedData 
    }

    func fetchProduct(with id: String) async throws -> Product {
        guard let url = URL(string: "\(productsBaseURL)/\(id)") else {
            throw WebServiceError.invalidURL
        }

        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode(Product.self, from: data)
        return decodedData
    }
}
