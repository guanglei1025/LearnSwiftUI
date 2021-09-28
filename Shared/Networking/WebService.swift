//
//  WebService.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 22/09/2021.
//

import Foundation

protocol WebService {
    func get<T: Decodable>(from url: URL) async throws -> T
    func post(with body: Data, to url: URL) async throws -> Data
}

final class Service: WebService {
    var session = URLSession.shared

    func get<T: Decodable>(from url: URL) async throws -> T {

        // Use the async variant of URLSession to fetch data
        let (data, _) = try await session.data(from: url)

        // Parse the JSON data
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func post(with body: Data, to url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body

        let (data, _) = try await session.data(for: request)

        return data
    }

    func put(with body: Data, to url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = body

        let (data, _) = try await session.data(for: request)

        return data
    }

    func delete(from url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (data, _) = try await session.data(for: request)

        return data
    }
}
