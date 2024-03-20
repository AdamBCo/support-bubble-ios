import Foundation
import Combine
import SwiftUI

@available(iOS 14.0, *)
class TicketDetailViewModel: ObservableObject {
    
    let id: Ticket.ID
    @Published var messages: [ChatMessage] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(id: Ticket.ID) {
        self.id = id
        listenToSocketEvents()
    }
    
    func listenToSocketEvents() {
        SocketClient.manager.defaultSocket.on("ticket-\(id):messages") { data, emitter in
            print("TICKET_MESSAGE: ", data)
        }
    }
    
    func loadMessages() async throws {
        messages = try await NetworkManager.shared.getRequest(path: "tickets/\(id)/messages")
    }
    
    func sendMessage(message: String) async throws {
        let clientID = SupportBubble.shared.clientID
//        let request = ChatMessageRequest(clientID: clientID, message: message, ticketID: id)
//        let json = try JSONEncoder().encode(request)
        SocketClient.manager.defaultSocket.emit("chat message", [
            "clientID": clientID,
            "message": message,
            "ticketID": id
        ])
    }
}
