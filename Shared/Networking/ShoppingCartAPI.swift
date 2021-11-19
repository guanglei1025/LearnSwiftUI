//
//  ShoppingCartAPI.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 29/09/2021.
//

import Foundation

protocol ShoppingCartService {
    func fetchShoppingCart() async throws -> ShoppingCart
    func deleteShoppingCart(_ newItem: ShoppingCart) async throws
    func updateShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart
    func submitShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart
    func saveShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart
}

final class ShoppingCartAPI: ShoppingCartService {
    private var webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }

    func fetchShoppingCart() async throws -> ShoppingCart {
        let url = ShoppingCartURL.fetch.url

        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode(ShoppingCart.self, from: data)
        return decodedData
    }

    func updateShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart {
        let url = ShoppingCartURL.update.url
    
        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.put(with: jsonData, to: url)

        let decodedData = try JSONDecoder().decode(ShoppingCart.self, from: taskResponse.data)
        return decodedData
   }

    func saveShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart {
        let url = ShoppingCartURL.save.url

        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.post(with: jsonData, to: url)
        
        let decodedData = try JSONDecoder().decode(ShoppingCart.self, from: taskResponse.data)
        return decodedData
    }

    func submitShoppingCart(_ newItem: ShoppingCart) async throws -> ShoppingCart {
        let url = ShoppingCartURL.submit.url

        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.post(with: jsonData, to: url)

        let decodedData = try JSONDecoder().decode(ShoppingCart.self, from: taskResponse.data)
        return decodedData
    }

    func deleteShoppingCart(_ newItem: ShoppingCart) async throws {
        let url = ShoppingCartURL.delete.url
        
        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.delete(with: jsonData, from: url)

        guard let response = taskResponse.response as? HTTPURLResponse else {
            throw WebServiceError.unexpectedStatusCode
        }
        print(response.statusCode)
    }
}
