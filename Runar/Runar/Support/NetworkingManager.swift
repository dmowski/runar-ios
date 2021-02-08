//
//  NetworkingManager.swift
//  Runar
//
//  Created by Юлия Лопатина on 9.02.21.
//

import Foundation

class NetworkingManager {
     func createUser(with id: String, date: Double, os: String){
         let json: [String: Any] = ["userToken" : id, "dataCreated" : date, "OS" : os]
         let jsonData = try? JSONSerialization.data(withJSONObject: json)
         let url = URL(string: "https://runar-testing.herokuapp.com/api/v1/create-user")!
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")

                request.httpBody = jsonData

                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                    }
                }

        task.resume()
    }
}
