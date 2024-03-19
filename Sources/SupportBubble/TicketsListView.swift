//
//  File.swift
//  
//
//  Created by Adam Cooper on 3/19/24.
//

import SwiftUI

@available(iOS 14.0.0, *)
public struct TicketsListView: View {
    
    public init() {
        
    }
    
    public var body: some View {
        Text("TicketsListView")
            .applyAuthGuard()
    }
}
