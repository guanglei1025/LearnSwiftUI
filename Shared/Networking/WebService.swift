//
//  WebService.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 22/09/2021.
//

import Foundation

public enum WebServiceError: Error {
    case invalidURL
    case unexpectedStatusCode
}

/// The types of requests we can handle
private enum RequestType: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

/// WebService knows how to call the server for typical operations
/// and how to send up and receive JSON bodies.
/// This provides an abstraction for testing and flexibility
protocol WebService {
    func get<T: Decodable>(from url: URL) async throws -> T
    func delete(from url: URL) async throws -> URLResponse
    func post(with body: Data, to url: URL) async throws -> URLResponse
    func put(with body: Data, to url: URL) async throws -> URLResponse
}

public typealias DataTaskResponse = (data: Data, response: URLResponse)

/// Service include implementations for the method that get from WebService
final class Service: WebService {
    var session = URLSession.shared

    // MARK: - Public API

    func get<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await sendRequest(url: url, requestType: .post, body: nil)

        // Parse the JSON data
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func post(with body: Data, to url: URL) async throws -> URLResponse {
        let (_, response) = try await sendRequest(url: url, requestType: .post, body: body)
        return response
    }

    func put(with body: Data, to url: URL) async throws -> URLResponse {
        let (_, response) = try await sendRequest(url: url, requestType: .put, body: body)
        return response
    }

    func delete(from url: URL) async throws -> URLResponse {
        let (_, response) = try await sendRequest(url: url, requestType: .delete, body: nil)
        return response
    }

    // MARK: - Private Helper Functions

    /// Craft the request, create the dataTaskResponse, and start it going
    private func sendRequest(url: URL, requestType: RequestType, body: Data?) async throws -> DataTaskResponse {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.httpBody = body

        // Use the async variant of URLSession to make the request
        let taskResponse: DataTaskResponse = try await session.data(for: request)

        guard let response = taskResponse.response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WebServiceError.unexpectedStatusCode
        }

        return taskResponse
    }
}
