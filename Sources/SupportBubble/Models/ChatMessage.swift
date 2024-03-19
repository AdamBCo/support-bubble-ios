//
//  File.swift
//  
//
//  Created by Adam Cooper on 3/19/24.
//

import Foundation

public struct ChatMessage: Identifiable, Decodable {
    public let id: String
    public let message: String?
}
