//
//  ShoppingCartAPI.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 29/09/2021.
//

import Foundation

protocol ShoppingCartService {
    func fetchShoppingCart(_ id: UUID) async throws -> ShoppingCart
    func saveShoppingCart(_ newItem: ShoppingCart) async throws
    func submitShoppingCart(_ newItem: ShoppingCart) async throws
    func deleteShoppingCart(_ newItem: ShoppingCart) async throws
}

final class ShoppingCartAPI: ShoppingCartService {
    private var webService: WebService

    init(webService: WebService) {
        self.webService = webService
    }

    func fetchShoppingCart(_ id: UUID) async throws -> ShoppingCart {
        guard let url = URL(string: "http://127.0.0.1:8080/shoppingCart/\(id)") else {
            throw WebServiceError.invalidURL
        }
        let data = try await webService.get(from: url)
        let decodedData = try JSONDecoder().decode(ShoppingCart.self, from: data)
        return decodedData
    }

    func saveShoppingCart(_ newItem: ShoppingCart) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/shoppingCart/save") else {
            throw WebServiceError.invalidURL
        }

        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.post(with: jsonData, to: url)

        guard let response = taskResponse.response as? HTTPURLResponse else {
            throw WebServiceError.unexpectedStatusCode
        }
        print(response.statusCode)
    }

    /// This api call will update product's stock quantity once a new order get submitted into shopping cart
    func submitShoppingCart(_ newItem: ShoppingCart) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/shoppingCart/submit") else {
            throw WebServiceError.invalidURL
        }

        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.post(with: jsonData, to: url)

        guard let response = taskResponse.response as? HTTPURLResponse else {
            throw WebServiceError.unexpectedStatusCode
        }
        print(response.statusCode)
    }

    func deleteShoppingCart(_ newItem: ShoppingCart) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/shoppingCart/delete") else {
            throw WebServiceError.invalidURL
        }
        
        let jsonData = try JSONEncoder().encode(newItem)
        let taskResponse = try await webService.delete(with: jsonData, from: url)

        guard let response = taskResponse.response as? HTTPURLResponse else {
            throw WebServiceError.unexpectedStatusCode
        }
        print(response.statusCode)
    }

    // TODO: Implement the API that can update shopping cart using `PUT: update-shopping-cart` endpoint once that endpoint get fixed
}

