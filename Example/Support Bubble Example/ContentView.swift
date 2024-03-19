//
//  ContentView.swift
//  Support Bubble Example
//
//  Created by Adam Cooper on 3/19/24.
//

import SupportBubble
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            NavigationLink {
                Tickets
            } label: {
                <#code#>
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
