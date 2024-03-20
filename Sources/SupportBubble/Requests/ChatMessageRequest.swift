import Foundation

struct ChatMessageRequest: Encodable {
    let clientID: String
    let message: String
    let ticketID: String
    
    public init(clientID: String, message: String, ticketID: String) {
        self.clientID = clientID
        self.message = message
        self.ticketID = ticketID
    }
}
