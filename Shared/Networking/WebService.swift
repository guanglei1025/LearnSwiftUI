//
//  WebService.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 22/09/2021.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
}

protocol WebService {
    func get() async throws -> Menu
}

final class ProductService: WebService {
    func get() async throws -> Menu {
        guard let url = URL(string: "http://127.0.0.1:8080/products") else {
            throw NetworkError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Menu.self, from: data)
    }
}
