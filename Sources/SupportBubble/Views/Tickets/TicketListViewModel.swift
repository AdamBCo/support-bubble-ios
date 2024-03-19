import Foundation
import Combine
import SwiftUI

@available(iOS 13.0, *)
class TicketListViewModel: ObservableObject {
    
    @Published var tickets: [Ticket] = []
    private var cancellables = Set<AnyCancellable>()
    
    func loadTickets() async throws {
        tickets = try await NetworkManager.shared.getRequest(path: "tickets")
    }
}
