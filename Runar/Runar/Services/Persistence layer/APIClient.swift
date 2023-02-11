//
//  APIClient.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import Foundation

// TODO: - Should be delete after testing
enum APIClientError: Error {
    case invalidResponse
}

final class APIClient<T: Codable> {
    func fetch(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw APIClientError.invalidResponse }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
