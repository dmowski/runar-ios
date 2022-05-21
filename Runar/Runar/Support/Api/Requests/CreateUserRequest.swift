//
//  CreateUserRequest.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/7/21.
//

import Foundation

public struct CreateUserRequest: Encodable {
    public let userToken: String
    public let dataCreated: Double
    public let OS: String
}
