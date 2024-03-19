//
//  File.swift
//  
//
//  Created by Adam Cooper on 3/19/24.
//

import Foundation

public struct Ticket: Identifiable, Decodable {
    public let id: String
    public let clientID: String
    public let customerID: String
    public let lastMessage: String?
}

extension Ticket: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
