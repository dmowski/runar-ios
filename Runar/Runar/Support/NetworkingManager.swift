//
//  NetworkingManager.swift
//  Runar
//
//  Created by Юлия Лопатина on 20.01.21.
//

import Foundation

class NetworkingManager {
    func createUser(with id: String, date: Double, os: String){
        let url = URL(string: "https://runar-testing.herokuapp.com/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String : Any] = ["userToken" : id, "created" : date, "OS" : os]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil
                else {
                print("error", error ?? "Unknown error")
                return}
            
        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        })
        task.resume()
    }
}
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
