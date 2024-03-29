//
//  ContentView.swift
//  Support Bubble Example
//
//  Created by Adam Cooper on 3/19/24.
//

import SupportBubble
import SwiftUI

struct ContentView: View {
    
    @State var showTicketListsView = false
    
    var body: some View {
        Button(action: {
            SupportBubble.shared.showTicketsView()
        }, label: {
            Text("Show Tickets")
        })
        .onAppear {
            SupportBubble.shared.clientID = "IThIYD5eCCvOlvXBsrHg"
            SupportBubble.shared.clientToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJRCI6IklUaElZRDVlQ0N2T2x2WEJzckhnIiwicGxhdGZvcm0iOiJpb3MiLCJjcmVhdGVkQXQiOiIyMDI0LTAzLTIwVDE1OjQ5OjA2Ljk2M1oiLCJpYXQiOjE3MTA5NDk3NDZ9.DhpUuAtmHwYaOoYXLlARWiG_lVQDUOMAT2l1UL0lb4g"
        }
        .sheet(isPresented: $showTicketListsView) {
            TicketsListView()
        }
    }
}

#Preview {
    ContentView()
}
