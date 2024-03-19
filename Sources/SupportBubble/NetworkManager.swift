//
//  File.swift
//  
//
//  Created by Adam Cooper on 3/19/24.
//

import Foundation

@available(iOS 13.0.0, *)
struct NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL = URL(string: "https://supportbubble-d48d6b6f228d.herokuapp.com/api/v1")!
    
    // Generic method to perform a request
    private func performRequest<T: Decodable>(
        to path: String,
        method: String,
        data: Data?,
        queryParameters: [String: String]? = nil
    ) async throws -> T {
        // Construct the full URL with query parameters if any
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        // Prepare the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(SupportBubble.shared.clientToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = data
        
        // Perform the network request
        let (responseData, response) = try await URLSession.shared.data(for: request)
        
        // Check the response code
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        // Decode the response
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
    
    // GET request
    func getRequest<T: Decodable>(path: String, queryParameters: [String: String]? = nil) async throws -> T {
        return try await performRequest(to: path, method: "GET", data: nil, queryParameters: queryParameters)
    }
    
    // POST request
    func postRequest<T: Decodable, U: Encodable>(path: String, data: U, queryParameters: [String: String]? = nil) async throws -> T {
        let encodedData = try JSONEncoder().encode(data)
        return try await performRequest(to: path, method: "POST", data: encodedData, queryParameters: queryParameters)
    }
    
    // PUT request
    func putRequest<T: Decodable, U: Encodable>(path: String, data: U, queryParameters: [String: String]? = nil) async throws -> T {
        let encodedData = try JSONEncoder().encode(data)
        return try await performRequest(to: path, method: "PUT", data: encodedData, queryParameters: queryParameters)
    }
}
