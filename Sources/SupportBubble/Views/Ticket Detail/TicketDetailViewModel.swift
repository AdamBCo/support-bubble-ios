import Foundation
import Combine
import SwiftUI

@available(iOS 13.0, *)
class TicketDetailViewModel: ObservableObject {
    
    let id: Ticket.ID
    @Published var messages: [ChatMessage] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(id: Ticket.ID) {
        self.id = id
    }
    
    func loadMessages() async throws {
        messages = try await NetworkManager.shared.getRequest(path: "tickets/\(id)/messages")
    }
    
    func sendMessage(message: String) async throws {
        let clientID = SupportBubble.shared.clientID
        let request = ChatMessageRequest(clientID: clientID, message: message, ticketID: id)
        let message: ChatMessage = try await NetworkManager.shared.postRequest(path: "messages", data: request)
        messages.append(message)
    }
}
