//
//  File.swift
//  
//
//  Created by Adam Cooper on 3/19/24.
//

import SwiftUI

@available(iOS 16.0.0, *)
public struct TicketsListView: View {
    
    @ObservedObject var viewModel = TicketListViewModel()
    
    public init() {
    }
    
    public var body: some View {
        NavigationStack {
            List(viewModel.tickets) { ticket in
                NavigationLink(value: ticket) {
                    Text(ticket.lastMessage ?? ticket.id)
                }
            }
            .task {
                do  {
                    try await viewModel.loadTickets()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .navigationTitle("Tickets")
            .navigationDestination(for: Ticket.self) { ticket in
                TicketDetailView(id: ticket.id)
            }
            .onAppear {
                SocketClient.connect()
            }
        }
        .modifier(AuthModifier())
    }
}
