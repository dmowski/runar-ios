//
//  RunarApi.swift
//  Runar
//
//  Created by Юлия Лопатина on 9.02.21.
//

import Foundation

class RunarApi {
    static func createUser(with id: String, date: Double, os: String) -> Void {
        let request = CreateUserRequest(userToken: id, dataCreated: date, OS: os)
        
        guard let jsonData = try? JSONEncoder().encode(request) else {
            return
        }
        
        post(jsonData, to: Route.createUser)
    }
    
    static func getLibratyHash() -> String? {
        guard let jsonData = get(from: Route.getLibraryHash) else {
            return nil
        }
        
        let hashData = try? JSONDecoder().decode([String: String].self, from: jsonData)
        
        return hashData?["hash"]
    }
    
    static func getLibratyData() -> Data? {
        return get(from: Route.getLibrary)
    }
}

extension RunarApi {
    private static func post(_ data: Data, to route: String) -> Void {
        guard let request = URLRequest.createPost(jsonData: data, to: route) else {
            return
        }
        
        send(request: request)
    }
    
    private static func get(from route: String) -> Data? {
        guard let request = URLRequest.createGet(from: route) else {
            return nil
        }
        
        return send(request: request)
    }
    
    @discardableResult private static func send(request: URLRequest) -> Data? {
        var result: Data? = nil
        let smartphone = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                smartphone.signal()
                return
            }
          
            result = data
            smartphone.signal()
        }
        
        task.resume()
        smartphone.wait()
        
        return result
    }
}

extension URLRequest {
    static func createGet(from: String) -> URLRequest? {
        return create(string: from, withMethod: .get)
    }
    
    static func createPost(jsonData: Data, to: String) -> URLRequest? {
        guard var request = create(string: to, withMethod: .post) else {return nil}
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        return request;
    }
    
    private static func create(string: String, withMethod method: HttpMthod) -> URLRequest? {
        guard let url = URL(string: string) else {return nil}
        
        var request = URLRequest(url: url);
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    enum HttpMthod: String, CaseIterable {
        case post = "POST"
        case get = "GET"
    }
}
