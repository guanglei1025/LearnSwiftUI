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
    func get(from url: URL) async throws -> Data
    func delete(with body: Data, from url: URL) async throws -> DataTaskResponse
    func post(with body: Data, to url: URL) async throws -> DataTaskResponse
    func put(with body: Data, to url: URL) async throws -> DataTaskResponse
}

public typealias DataTaskResponse = (data: Data, response: URLResponse)

/// Service include implementations for the method that get from WebService
final class Service: WebService {
    var session = URLSession.shared

    // MARK: - Public API

    func get(from url: URL) async throws -> Data {
        let taskResponse: DataTaskResponse = try await sendRequest(url: url, requestType: .get, body: nil)
        return taskResponse.data
    }

    func post(with body: Data, to url: URL) async throws -> DataTaskResponse {
        let taskResponse: DataTaskResponse = try await sendRequest(url: url, requestType: .post, body: body)
        return taskResponse
    }

    func put(with body: Data, to url: URL) async throws -> DataTaskResponse {
        let taskResponse: DataTaskResponse  = try await sendRequest(url: url, requestType: .put, body: body)
        return taskResponse
    }

    func delete(with body: Data, from url: URL) async throws -> DataTaskResponse {
        let taskResponse: DataTaskResponse = try await sendRequest(url: url, requestType: .delete, body: body)
        return taskResponse
    }

    // MARK: - Private Helper Functions

    /// Craft the request, create the dataTaskResponse, and start it going
    private func sendRequest(url: URL, requestType: RequestType, body: Data?) async throws -> DataTaskResponse {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.httpBody = body

        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Use the async variant of URLSession to make the request
        let taskResponse: DataTaskResponse = try await session.data(for: request)

        guard let response = taskResponse.response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WebServiceError.unexpectedStatusCode
        }

        return taskResponse
    }
}
