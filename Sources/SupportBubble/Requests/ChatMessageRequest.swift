import Foundation

public struct ChatMessageRequest: Encodable {
    
    public let clientID: String
    public let message: String
    public let ticketID: Ticket.ID
    
    public init(clientID: String, message: String, ticketID: Ticket.ID) {
        self.clientID = clientID
        self.message = message
        self.ticketID = ticketID
    }
}
